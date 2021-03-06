function gadget:GetInfo()
	return {
		name = "Game Radar",
		desc = "Units in radar range become visible",
		author = "FLOZi (C. Lawrence)",
		date = "02/02/2011",
		license = "GNU GPL v2",
		layer = 3, -- must be after lus_helper
		enabled = true,
	}
end

if (gadgetHandler:IsSyncedCode()) then
--SYNCED

-- Localisations
local DelayCall = GG.Delay.DelayCall
local SetUnitRulesParam	= Spring.SetUnitRulesParam
-- Synced Read
local GetGameFrame 		= Spring.GetGameFrame
local GetTeamInfo		= Spring.GetTeamInfo
local GetUnitIsActive 	= Spring.GetUnitIsActive
local GetUnitIsDead 	= Spring.GetUnitIsDead
local GetUnitLosState	= Spring.GetUnitLosState
local GetUnitRulesParam	= Spring.GetUnitRulesParam
local GetUnitSeparation	= Spring.GetUnitSeparation
local GetUnitTeam		= Spring.GetUnitTeam
-- Synced Ctrl
local SetUnitLosMask 	= Spring.SetUnitLosMask
local SetUnitLosState 	= Spring.SetUnitLosState

-- Unsynced Ctrl
-- Constants

local FRAME_FUDGE = 16

local BEACON_ID = UnitDefNames["beacon"].id

local NARC_ID = WeaponDefNames["narc"].id
local NARC_DURATION = 30 * 30 -- 30 seconds
Spring.SetGameRulesParam("NARC_DURATION", NARC_DURATION)

local TAG_ID = WeaponDefNames["tag"].id
local PPC_IDS = {}
for weaponDefID, weaponDef in pairs(WeaponDefs) do
	if weaponDef.name:find("ppc") then
		PPC_IDS[weaponDefID] = true
	end
end

local mobileUnitDefs = {}
local mobileUnits = {}
local visionCache = {} -- visionCache[unitDefID] = {x = sectorVectorX, z = sectorVectorZ, sight = lastWeaponNum}
for unitDefID, unitDef in pairs(UnitDefs) do
	local cp = unitDef.customParams
	if cp.baseclass == "mech" and cp.sectorangle then
		local angle = tonumber(cp.sectorangle) -- defaults in unitdefs_post
		local s1x, s1z = GG.Vector.SectorVectorsFromAngle(math.rad(angle), unitDef.losRadius)
		visionCache[unitDefID] = {
			x = s1x,
			z = s1z,
			sight = #unitDef.weapons, -- always make the sight weapon the last one
		}
		mobileUnitDefs[unitDefID] = true
	elseif cp.baseclass == "vehicle" then
		mobileUnitDefs[unitDefID] = true
	end
end

-- Variables
local modOptions = Spring.GetModOptions()
local inRadarUnits = {}
local outRadarUnits = {}
local allyJammers = {} -- allyJammers[unitID] = radius
GG.allyJammers = allyJammers
local allyBAPs = {} -- allyBAPs[unitID] = radius
GG.allyBAPs = allyBAPs

local allyTeams = Spring.GetAllyTeamList()
local numAllyTeams = #allyTeams
local teamsInAllyTeams = {}
local deadTeams = {}
local allyTeamMechs = {}

local sectorUnits = {}
local prevSectorUnits = {}
for i = 1, numAllyTeams do
	local allyTeam = allyTeams[i]
	inRadarUnits[allyTeam] = {}
	outRadarUnits[allyTeam] = {}
	allyJammers[allyTeam] = {}
	allyBAPs[allyTeam] = {}
	teamsInAllyTeams[allyTeam] = Spring.GetTeamList(allyTeam)
	sectorUnits[allyTeam] = {}
	prevSectorUnits[allyTeam] = {}
	allyTeamMechs[allyTeam] = {}
end

local narcUnits = {}

local PPC_DURATION = 5 * 30 -- 5 seconds
local sensorTypes = {"radar", "seismic", "radarJammer"}
local unitSensorRadii = {} -- unitSensorRadii[unitID] = {radar = a, seismic = b ...}
local ppcUnits = {} -- ppcUnits[unitID] = gameframe
local bapUnits = {} -- bapUnits[unitID] = {gameframe, allyTeam}
local ecmUnits = {} -- ecmUnits[unitID] = {gameframe, allyTeam}

-- cache los tables (table creation is expensive!)
local prevLosTrue = {prevLos = true, contRadar=true}
local prevLosOnly = {los = false, prevLos = true, radar = false, contRadar = true}
local losTrue = {los = true}
local losFalseRestTrue = {los = false, prevLos = true, radar = true, contRadar = true}
local fullLOS = {los = true, prevLos = true, radar = true, contRadar = true}

local function FinishPPC(unitID)
	if ppcUnits[unitID] and ppcUnits[unitID] <= Spring.GetGameFrame() then
		for _, sensorType in pairs(sensorTypes) do
			Spring.SetUnitSensorRadius(unitID, sensorType, unitSensorRadii[unitID][sensorType])
		end
		ppcUnits[unitID] = nil
		SetUnitRulesParam(unitID, "PPC_HIT", -1, {inlos = true})
	end
end

local function ApplyPPC(unitID)
	if not ppcUnits[unitID] then -- not yet under PPC effects
		unitSensorRadii[unitID] = {}
		for _, sensorType in pairs(sensorTypes) do
			-- perks change radii so can't rely on unitdef values
			unitSensorRadii[unitID][sensorType] = Spring.GetUnitSensorRadius(unitID, sensorType)
			Spring.SetUnitSensorRadius(unitID, sensorType, 0) -- ECM & BAP are disabled altogether
		end
		-- BAP is disabled - return to regular radar (TODO: should really reset the emit height too! Needs engine change)
		-- FIXME: set these default values in a single place and read them from there
		Spring.SetUnitSensorRadius(unitID, "radar", 2000) --L138 unitdefs_post
	end
	local delay = (GetUnitRulesParam(unitID, "insulation") or 1) * PPC_DURATION
	ppcUnits[unitID] = Spring.GetGameFrame() + delay
	SetUnitRulesParam(unitID, "PPC_HIT", ppcUnits[unitID], {inlos = true})
	GG.Delay.DelayCall(FinishPPC, {unitID}, delay)
end

local function GetUnitUnderJammer(unitID)
	return (GetUnitRulesParam(unitID, "FRIENDLY_ECM") or 0) + FRAME_FUDGE >= GetGameFrame() 
end
GG.GetUnitUnderJammer = GetUnitUnderJammer

-- helper functions for LUS
local function IsUnitNARCed(unitID)
	return (GetUnitRulesParam(unitID, "NARC") or 0) > 0
end
GG.IsUnitNARCed = IsUnitNARCed

local function IsUnitTAGed(unitID)
	return (GetUnitRulesParam(unitID, "TAG") or 0) + FRAME_FUDGE >= GetGameFrame()
end
GG.IsUnitTAGed = IsUnitTAGed

local function ResetLosStates(unitID, allyTeam)
	-- don't reset for turrets or outposts etc, they remain always visible once detected by whatever means
	if Spring.ValidUnitID(unitID) and not Spring.GetUnitIsDead(unitID) and mobileUnits[unitID] then
		--Spring.Echo("Reset los states for", unitID)
		SetUnitLosMask(unitID, allyTeam, prevLosOnly)
		if sectorUnits[allyTeam][unitID] then
			SetUnitLosState(unitID, allyTeam, fullLOS)
		else
			local states = GetUnitLosState(unitID, allyTeam)
			SetUnitLosState(unitID, allyTeam, {radar = states.radar, los = false})
		end
	end
end

local function NARC(unitID, allyTeam, duration)
	local narcFrame = GetGameFrame() + duration
	narcUnits[unitID] = {frame = narcFrame, allyTeam = allyTeam}
	SetUnitLosState(unitID, allyTeam, {los=true, prevLos=true, radar=true, contRadar=true} ) 
	SetUnitLosMask(unitID, allyTeam, {los=true, prevLos=false, radar=false, contRadar=false} )	
	-- Set rules param here so that widgets know the unit is NARCed, value points to the frame NARC runs out
	SetUnitRulesParam(unitID, "NARC", narcFrame, {inlos = true})
end

local function DeNARC(unitID, allyTeam, force)
	if not GetUnitIsDead(unitID) and narcUnits[unitID] and (narcUnits[unitID].frame <= GetGameFrame() + 1 or force) then
		narcUnits[unitID] = nil
		-- unset rules param
		SetUnitRulesParam(unitID, "NARC", -1, {inlos = true})
		ResetLosStates(unitID, allyTeam)
	end
end


function gadget:UnitPreDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponID, projectileID, attackerID, attackerDefID, attackerTeam)
	-- Don't allow any damage to beacons or dropzones
	if unitDefID == BEACON_ID or UnitDefs[unitDefID].name:find("dropzone") or UnitDefs[unitDefID].customParams.decal then return 0 end
	-- ignore none weapons
	if not attackerID then return damage end
	-- NARCs
	if weaponID == NARC_ID then
		-- Don't allow dropships to be NARCed
		if UnitDefs[unitDefID].customParams.dropship then return 0 end
		--if GetUnitUnderJammer(unitID, unitTeam) then return 0 end
		local allyTeam = select(6, GetTeamInfo(attackerTeam))
		-- do the NARC, delay the deNARC
		local duration = GetUnitRulesParam(attackerID, "NARC_DURATION") or NARC_DURATION
		NARC(unitID, allyTeam, duration)
		DelayCall(DeNARC, {unitID, allyTeam}, duration)
		-- NARC does 0 damage
		return 0
	elseif weaponID == TAG_ID then
		-- Don't allow dropships to be TAGed
		if not UnitDefs[unitDefID].customParams.dropship then
			SetUnitRulesParam(unitID, "TAG", GetGameFrame(), {inlos = true})
			--Spring.Echo("I AM BEING TAGGED!")
		end
		return 0
	elseif PPC_IDS[weaponID] then
		ApplyPPC(unitID)
	end
	return damage, 1
end


function gadget:UnitCreated(unitID, unitDefID, teamID)
	local ud = UnitDefs[unitDefID]
	local jamRadius = ud.jammerRadius
	if jamRadius > 0 then
		local allyTeam = select(6, GetTeamInfo(teamID))
		allyJammers[allyTeam][unitID] = jamRadius
	end
	if ud.customParams.bap then
		local allyTeam = select(6, GetTeamInfo(teamID))
		allyBAPs[allyTeam][unitID] = Spring.GetUnitSensorRadius(unitID, "radar") -- can be perked! TODO: update this via perk side too
	end
	if mobileUnitDefs[unitDefID] then
		mobileUnits[unitID] = true
	end
	if visionCache[unitDefID] then -- a mech!
		visionCache[unitDefID].torso = GG.lusHelper[unitDefID].torso
		allyTeamMechs[Spring.GetUnitAllyTeam(unitID)][unitID] = visionCache[unitDefID]
		-- force Spring to think this unit has previously been in LOS, so that the correct radar icon is shown
		for i = 1, numAllyTeams do
			local allyTeam = allyTeams[i]
			SetUnitLosState(unitID, allyTeam, prevLosTrue)
			SetUnitLosMask(unitID, allyTeam, prevLosTrue)
		end
	end
end

function gadget:UnitEnteredRadar(unitID, unitTeam, allyTeam, unitDefID)
	if mobileUnitDefs[unitDefID] then
		inRadarUnits[allyTeam][unitID] = true
		--Spring.Echo("UER:", unitID, unitTeam, UnitDefs[unitDefID].name)
	else
		-- statics are perma-visible
		GG.Delay.DelayCall(SetUnitLosState, {unitID, allyTeam, fullLOS}, 1)
		GG.Delay.DelayCall(SetUnitLosMask, {unitID, allyTeam, fullLOS}, 1) -- don't let engine update any los status
	end
end

function gadget:UnitLeftRadar(unitID, unitTeam, allyTeam, unitDefID)
	if mobileUnitDefs[unitDefID] then
		--outRadarUnits[allyTeam][unitID] = true
		inRadarUnits[allyTeam][unitID] = nil
	end
end

function gadget:UnitEnteredLOS(unitID, unitTeam, allyTeam, unitDefID)
	if mobileUnitDefs[unitDefID] then
		inRadarUnits[allyTeam][unitID] = nil
		--Spring.Echo("UER:", unitID, unitTeam, UnitDefs[unitDefID].name)
	end
end

function gadget:UnitLeftLOS(unitID, unitTeam, allyTeam, unitDefID)
	if mobileUnitDefs[unitDefID] then
		--outRadarUnits[allyTeam][unitID] = true
		inRadarUnits[allyTeam][unitID] = Spring.IsUnitInRadar(unitID, allyTeam)
	end
end

function gadget:UnitDestroyed(unitID, unitDefID, teamID)
	for i = 1, numAllyTeams do
		local allyTeam = allyTeams[i]
		inRadarUnits[allyTeam][unitID] = nil
		--outRadarUnits[allyTeam][unitID] = nil
		allyJammers[allyTeam][unitID] = nil
	end
	mobileUnits[unitID] = nil
	narcUnits[unitID] = nil
	ppcUnits[unitID] = nil
	bapUnits[unitID] = nil
	ecmUnits[unitID] = nil
	allyTeamMechs[Spring.GetUnitAllyTeam(unitID)][unitID] = nil
	SetUnitRulesParam(unitID, "FRIENDLY_ECM", 0)
end

function gadget:UnitGiven(unitID, unitDefID, newTeam, oldTeam)
	for i = 1, numAllyTeams do
		local allyTeam = allyTeams[i]
		inRadarUnits[allyTeam][unitID] = nil
		--outRadarUnits[allyTeam][unitID] = nil
		allyJammers[allyTeam][unitID] = nil
	end
	SetUnitRulesParam(unitID, "FRIENDLY_ECM", 0)
	gadget:UnitCreated(unitID, unitDefID, newTeam)
end


function gadget:GameFrame(n)
	-- reset any BAP'd units before re-checking los & radar states
	for bapped, data in pairs(bapUnits) do
		if data[1] < n - FRAME_FUDGE then
			if Spring.ValidUnitID(bapped) and not Spring.GetUnitIsDead(bapped) then
				ResetLosStates(bapped, data[2])
			end
			bapUnits[bapped] = nil
		end
	end
	-- TODO: needed?
	for ecmed, data in pairs(ecmUnits) do
		if data[1] < n - FRAME_FUDGE then
			--if Spring.ValidUnitID(ecmed) and not Spring.GetUnitIsDead(ecmed) then
			--	ResetLosStates(bapped, data[2])
			--end
			ecmUnits[ecmed] = nil
		end
	end
	
	local GetUnitPosition 	= Spring.GetUnitPosition
	for i = 1, numAllyTeams do
		local allyTeam = allyTeams[i]
		-- Firstly ECM units
		for unitID, ecmRadius in pairs(allyJammers[allyTeam]) do
			-- only active non-PPC'd units can utilise BAP and ECM
			if not ppcUnits[unitID] and GetUnitIsActive(unitID) then
				for _, teamID in pairs(teamsInAllyTeams[allyTeam]) do
					if not deadTeams[teamID] then
						local x, _, z = GetUnitPosition(unitID)
						local nearbyUnits = Spring.GetUnitsInCylinder(x, z, ecmRadius, teamID)
						--Spring.Echo("Jammer", jammerID, "(", UnitDefs[Spring.GetUnitDefID(jammerID)].name, ")")
						for _, enemyID in pairs(nearbyUnits) do
							--Spring.Echo("nearby", UnitDefs[Spring.GetUnitDefID(nearbyUnits[i])].name)
							SetUnitRulesParam(enemyID, "FRIENDLY_ECM", n, {inlos = true})
							ecmUnits[enemyID] = {n, allyTeam}
						end
					end
				end
			end
		end
		-- Secondly BAP units
		for unitID, bapRadius in pairs(allyBAPs[allyTeam]) do
			-- only active non-PPC'd units can utilise BAP and ECM
			-- TODO: probably we want BAP passive/active toggle to be seperate from main radar activation state?
			if not ppcUnits[unitID] and GetUnitIsActive(unitID) then
				local x, _, z = GetUnitPosition(unitID)
				local nearbyUnits = Spring.GetUnitsInCylinder(x, z, bapRadius)
				for _, enemyID in pairs(nearbyUnits) do
					local unitAllyTeam = Spring.GetUnitAllyTeam(enemyID)
					if enemyID ~= unitID and unitAllyTeam ~= allyTeam then -- and not sectorUnits[allyTeam][enemyID] then -- not in another sector
						if allyJammers[unitAllyTeam][enemyID] then -- jammers only vs ecmUnits[enemyID] for all ecm'd mechs
							if n % 30 == 0 then -- every second
								local ex, ey, ez = Spring.GetUnitPosition(enemyID)
								Spring.SpawnCEG("ecm_ping", ex,ey,ez)
							end
						elseif ecmUnits[enemyID] then 
							-- nothing, should still be invisible to bap
						else
							bapUnits[enemyID] = {n, allyTeam}
							SetUnitLosState(enemyID, allyTeam, fullLOS) 
							SetUnitLosMask(enemyID, allyTeam, losTrue)	-- let lua handle los state for this unit
							--[[if n % 30 == 0 then -- every second
								local ex, ey, ez = Spring.GetUnitPosition(enemyID)
								Spring.SpawnCEG("bap_ping", ex,ey,ez)
							end]]
						end
					end
				end
			end
		end
		-- Finally all sector mechs
		for unitID, info in pairs(allyTeamMechs[allyTeam]) do
			if Spring.ValidUnitID(unitID) and not Spring.GetUnitIsDead(unitID) then
				local x, _, z = GetUnitPosition(unitID)
				local inRadius = Spring.GetUnitsInCylinder(x, z, Spring.GetUnitSensorRadius(unitID, "radar")) -- use current sensor radius here as perks can change it
				if not info.torso then Spring.Echo("Oh shit, ", UnitDefs[Spring.GetUnitDefID(unitID)].name, "seems to have no cockpit") else
					local v1x, v1z, v2x, v2z = GG.Vector.SectorVectorsFromUnitPiece(unitID, info.torso, info.x, info.z)
					--Spring.MarkerAddPoint(x + v1x, 0, z + v1z, "V1")
					--Spring.MarkerAddPoint(x + v2x, 0, z + v2z, "V2")
					for _, enemyID in pairs(inRadius) do
						local unitAllyTeam = Spring.GetUnitAllyTeam(enemyID)
						if mobileUnits[enemyID] 
						and (inRadarUnits[allyTeam][enemyID] or ecmUnits[enemyID]
						or (not Spring.GetUnitIsActive(enemyID) or not Spring.GetUnitIsActive(unitID))
						and not (bapUnits[enemyID] and bapUnits[enemyID][2] == allyTeam)) then
							local ex, _, ez = GetUnitPosition(enemyID)
							local inSector = GG.Vector.IsInsideSectorVector(ex, ez, x, z, v1x, v1z, v2x, v2z)
							if inSector then
								-- check it is really my sector giving them los
								local rayTrace = Spring.GetUnitWeaponHaveFreeLineOfFire(unitID, info.sight, enemyID)
								if rayTrace then
									SetUnitLosState(enemyID, allyTeam, fullLOS)
									SetUnitLosMask(enemyID, allyTeam, prevLosTrue)
									sectorUnits[allyTeam][enemyID] = true
								end
							elseif not sectorUnits[allyTeam][enemyID] then -- not in another sector
								SetUnitLosState(enemyID, allyTeam, {los = Spring.IsUnitInLos(enemyID, allyTeam), prevLos = true, radar = true, contRadar = true}) 
								SetUnitLosMask(enemyID, allyTeam, losTrue) -- let engine handle los state for this unit	
							else
								-- Not in any sector
							end
						end
					end
				end
			end
		end
		for enemyID in pairs(prevSectorUnits[allyTeam]) do
			if not sectorUnits[allyTeam][enemyID] and not (bapUnits[enemyID] and bapUnits[enemyID][2] == allyTeam) then 
			-- unit was previously in a sector but is now not inside any radius, reset states
				SetUnitLosState(enemyID, allyTeam, {los = Spring.IsUnitInLos(enemyID, allyTeam), prevLos = true, radar = Spring.IsUnitInRadar(enemyID, allyTeam), contRadar = true}) 
				SetUnitLosMask(enemyID, allyTeam, losTrue) -- let engine handle los state for this unit	
			end
		end
		table.copy(sectorUnits[allyTeam], prevSectorUnits[allyTeam])
		sectorUnits[allyTeam] = {}
	end
	if Spring.IsGameOver() then
		gadgetHandler:RemoveGadget()
	end
end

function gadget:TeamDied(teamID)
	deadTeams[teamID] = true
end

else

-- UNSYNCED

end
