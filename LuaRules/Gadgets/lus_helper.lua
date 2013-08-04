function gadget:GetInfo()
	return {
		name = "LUS Helper",
		desc = "Parses UnitDef and Model data for LUS",
		author = "FLOZi (C. Lawrence)",
		date = "20/02/2011", -- 25 today ;_;
		license = "GNU GPL v2",
		layer = -1,
		enabled = true
	}
end

if (gadgetHandler:IsSyncedCode()) then
--SYNCED

-- Localisations
GG.lusHelper = {}
sqrt = math.sqrt
-- Synced Read
local GetUnitPieceInfo 		= Spring.GetUnitPieceInfo
local GetUnitPieceMap		= Spring.GetUnitPieceMap
local GetUnitPiecePosDir	= Spring.GetUnitPiecePosDir
local GetUnitPosition		= Spring.GetUnitPosition
-- Synced Ctrl
local PlaySoundFile			= Spring.PlaySoundFile
local SpawnCEG				= Spring.SpawnCEG
-- LUS
local CallAsUnit 			= Spring.UnitScript.CallAsUnit	

-- Unsynced Ctrl
-- Constants
-- Variables

-- Useful functions for GG

function EmitSfxName(unitID, pieceName, effectName)
	local x,y,z,dx,dy,dz = GetUnitPiecePosDir(unitID, pieceName)
	SpawnCEG(effectName, x,y,z, dx, dy, dz)
end

local function RecursiveHide(unitID, pieceNum)
	-- Hide this piece
	CallAsUnit(unitID, Spring.UnitScript.Hide, pieceNum)
	-- Recursively hide children
	local pieceMap = GetUnitPieceMap(unitID)
	local children = GetUnitPieceInfo(unitID, pieceNum).children
	if children then
		for _, pieceName in pairs(children) do
			--Spring.Echo("pieceName:", pieceName, pieceMap[pieceName])
			RecursiveHide(unitID, pieceMap[pieceName])
		end
	end
end
GG.RecursiveHide = RecursiveHide

local function PlaySoundAtUnit(unitID, sound, volume, sx, sy, sz, channel)
	local x,y,z = GetUnitPosition(unitID)
	volume = volume or 5
	channel = channel or "sfx"
	PlaySoundFile(sound, volume, x, y, z, sx, sy, sz, channel)
end
GG.PlaySoundAtUnit = PlaySoundAtUnit

local function GetUnitDistanceToPoint(unitID, tx, ty, tz, bool3D)
	local x,y,z = GetUnitPosition(unitID)
	local dy = (bool3D and ty and (ty - y)^2) or 0
	local distanceSquared = (tx - x)^2 + (tz - z)^2 + dy
	return sqrt(distanceSquared)
end
GG.GetUnitDistanceToPoint = GetUnitDistanceToPoint

local function StringToTable(input)
	return loadstring("return " .. (input or "{}"))()
end
GG.StringToTable = StringToTable

local function GetArmMasterWeapon(input)
	local lowestID = 32
	for weaponID, valid in pairs(input) do
		if valid then
			if weaponID < lowestID then lowestID = weaponID end
		end
	end
	return lowestID
end

local function IsPieceAncestor(unitID, pieceName, ancestor)
	local pieceMap = GetUnitPieceMap(unitID)
	local parent = GetUnitPieceInfo(unitID, pieceMap[pieceName]).parent
	if parent:find(ancestor) then return true
	elseif parent == "" or parent == nil then
		return false
	else
		return IsPieceAncestor(unitID, parent, ancestor)
	end
end

function gadget:UnitCreated(unitID, unitDefID, teamID, builderID)
	local info = GG.lusHelper[unitDefID]
	local cp = UnitDefs[unitDefID].customParams
	info.builderID = builderID
	if info.arms == nil then --and not UnitDefs[unitDefID].name:find("dropship") then
		-- Parse Model Data
		local pieceMap = GetUnitPieceMap(unitID)
		info.arms = pieceMap["rupperarm"] ~= nil
		local leftArmIDs = {}
		local rightArmIDs = {}
		
		local launcherIDs = {}
		local turretIDs = {}
		local mantletIDs = {}
		local barrelIDs = {}
		local numWheels = 0
		for pieceName, pieceNum in pairs(pieceMap) do
			local parent = GetUnitPieceInfo(unitID, pieceNum)["parent"]
			local weapNumPos = pieceName:find("_") or 0
			local weaponNum = tonumber(pieceName:sub(weapNumPos+1,weapNumPos+1))
			-- Find launcher pieces
			if pieceName:find("launcher_") then
				launcherIDs[weaponNum] = true
			-- Find mantlet pieces
			elseif pieceName:find("mantlet_") then
				mantletIDs[weaponNum] = true
			-- Find barrel pieces
			elseif pieceName:find("barrel_") then
				barrelIDs[weaponNum] = true
				leftArmIDs[weaponNum] = leftArmIDs[weaponNum] or IsPieceAncestor(unitID, pieceName, "lupperarm")
				rightArmIDs[weaponNum] = rightArmIDs[weaponNum] or IsPieceAncestor(unitID, pieceName, "rupperarm")
			-- Find the number of wheels
			elseif pieceName:find("wheel") then
				numWheels = numWheels + 1
			-- assign flare weaponIDs to left or right arms
			elseif pieceName:find("flare_") then
				leftArmIDs[weaponNum] = leftArmIDs[weaponNum] or IsPieceAncestor(unitID, pieceName, "lupperarm")
				rightArmIDs[weaponNum] = rightArmIDs[weaponNum] or IsPieceAncestor(unitID, pieceName, "rupperarm")
			-- assign launchpoint weaponIDs to left or right arms
			elseif pieceName:find("launchpoint_") then
				leftArmIDs[weaponNum] = leftArmIDs[weaponNum] or IsPieceAncestor(unitID, pieceName, "lupperarm")
				rightArmIDs[weaponNum] = rightArmIDs[weaponNum] or IsPieceAncestor(unitID, pieceName, "rupperarm")
			end
		end
		
		if cp.unittype == "mech" then
			info.rightArmMasterID = GetArmMasterWeapon(rightArmIDs)
			info.leftArmMasterID = GetArmMasterWeapon(leftArmIDs)
			info.rightArmIDs = rightArmIDs
			info.leftArmIDs = leftArmIDs
		end
		
		info.launcherIDs = launcherIDs
		info.turretIDs = turretIDs
		info.mantletIDs = mantletIDs
		info.barrelIDs = barrelIDs
		info.numWheels = numWheels
	end
end

function gadget:GamePreload()
	-- Parse UnitDef Data
	for unitDefID, unitDef in pairs(UnitDefs) do
		local info = {}
		local cp = unitDef.customParams
		local weapons = unitDef.weapons
		
		-- Parse UnitDef Weapon Data
		local missileWeaponIDs = {}
		local jammableIDs = {}
		local burstLengths = {}
		local firingHeats = {}		
		local reloadTimes = {}
		local ammoTypes = {}
		local minRanges = {}
		local spinSpeeds = {}
		for i = 1, #weapons do
			local weaponInfo = weapons[i]
			local weaponDef = WeaponDefs[weaponInfo.weaponDef]
			reloadTimes[i] = weaponDef.reload
			burstLengths[i] = weaponDef.salvoSize
			firingHeats[i] = (weaponDef.customParams.heatgenerated or 0) * 0.5
			ammoTypes[i] = weaponDef.customParams.ammotype -- intentionally nil otherwise
			minRanges[i] = tonumber(weaponDef.customParams.minrange) -- intentionally nil otherwise
			spinSpeeds[i] = weaponDef.customParams.spinspeed and math.rad(weaponDef.customParams.spinspeed)
			if weaponDef.type == "MissileLauncher" and weaponDef.name ~= "narc" then --burstLengths[i] > 1 then
				missileWeaponIDs[i] = true
			end
			if weaponDef.interceptor == 1 then
				info.amsID = i
			end
			jammableIDs[i] = (tonumber(weaponDef.customParams.jammable) == 1)
		end
		-- WeaponDef Level Info
		info.missileWeaponIDs = missileWeaponIDs
		info.reloadTimes = reloadTimes
		info.burstLengths = burstLengths
		info.firingHeats = firingHeats
		info.ammoTypes = ammoTypes
		info.minRanges = minRanges
		info.spinSpeeds = spinSpeeds
		info.jammableIDs = jammableIDs
		
		-- UnitDef Level Info
		-- Mechs
		info.jumpjets = GG.jumpDefs[unitDefID] ~= nil
		info.torsoTurnSpeed = math.rad(tonumber(cp.torsoturnspeed) or 100)
		-- Limb HPs
		info.limbHPs = {}
		if cp.unittype == "mech" then
			info.limbHPs["left_leg"] = unitDef.health * 0.1
			info.limbHPs["right_leg"] = unitDef.health * 0.1
			info.limbHPs["left_arm"] = unitDef.health * 0.15
			info.limbHPs["right_arm"] = unitDef.health * 0.15
		elseif cp.unittype == "vehicle" then
			info.limbHPs["turret"] = unitDef.health * 0.25
		end
		-- Vehicles
		info.hover = unitDef.moveData.family == "hover"
		info.vtol = unitDef.hoverAttack
		info.aero = unitDef.myGravity
		info.turrets = StringToTable(cp.turrets)
		info.turretTurnSpeed = math.rad(tonumber(cp.turretturnspeed) or 75)
		info.turret2TurnSpeed = math.rad(tonumber(cp.turret2turnspeed) or 75)
		info.barrelRecoilSpeed = (tonumber(cp.barrelrecoilspeed) or 100)
		info.barrelRecoilDist = StringToTable(cp.barrelrecoildist)
		info.wheelSpeed = math.rad(tonumber(cp.wheelspeed) or 100)
		info.wheelAccel = math.rad(tonumber(cp.wheelaccel) or info.wheelSpeed * 2)
		-- General
		info.heatLimit = (tonumber(cp.heatlimit) or 50) * 10
		info.coolRate = info.heatLimit / 50 -- or a constant rate of 10?
		info.numWeapons = #weapons
		info.elevationSpeed = math.rad(tonumber(cp.elevationspeed) or math.deg(info.torsoTurnSpeed))
		info.maxAmmo = StringToTable(cp.maxammo)
		-- And finally, stick it in GG for the script to access
		GG.lusHelper[unitDefID] = info
	end
	
end

function gadget:Initialize()
	gadget:GamePreload()
	for _,unitID in ipairs(Spring.GetAllUnits()) do
		local teamID = Spring.GetUnitTeam(unitID)
		local unitDefID = Spring.GetUnitDefID(unitID)
		gadget:UnitCreated(unitID, unitDefID, teamID)
		-- restart all LUS too (none functional atm - unit_script runs first?)
		--[[env = Spring.UnitScript.GetScriptEnv(unitID)
		Spring.UnitScript.CallAsUnit(unitID, env.Script.Create)]]
	end
end

function gadget:MoveCtrlNotify(unitID, unitDefID, unitTeam, data)
	local BEACON_ID = UnitDefNames["beacon"].id
	if unitDefID == BEACON_ID then
		env = Spring.UnitScript.GetScriptEnv(unitID)
		Spring.UnitScript.CallAsUnit(unitID, env.TouchDown)
		Spring.MoveCtrl.Disable(unitID)
	end
end

else

-- UNSYNCED

end
