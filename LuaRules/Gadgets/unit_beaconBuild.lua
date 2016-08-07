function gadget:GetInfo()
	return {
		name		= "Beacon Construction",
		desc		= "Controls beacons' construction abilities",
		author		= "FLOZi (C. Lawrence)",
		date		= "10/08/13",
		license 	= "GNU GPL v2",
		layer		= 0,
		enabled	= true	--	loaded by default?
	}
end

if gadgetHandler:IsSyncedCode() then
--	SYNCED

-- localisations
local SetUnitRulesParam		= Spring.SetUnitRulesParam
--SyncedRead
local GetGameFrame			= Spring.GetGameFrame
local GetTeamResources		= Spring.GetTeamResources
local GetUnitPosition		= Spring.GetUnitPosition
--SyncedCtrl
local CreateUnit			= Spring.CreateUnit
local DestroyUnit			= Spring.DestroyUnit
local EditUnitCmdDesc		= Spring.EditUnitCmdDesc
local InsertUnitCmdDesc		= Spring.InsertUnitCmdDesc
local FindUnitCmdDesc		= Spring.FindUnitCmdDesc
local TransferUnit			= Spring.TransferUnit
local RemoveUnitCmdDesc		= Spring.RemoveUnitCmdDesc
local SetUnitNeutral		= Spring.SetUnitNeutral
local SetUnitRotation		= Spring.SetUnitRotation
local UseTeamResource 		= Spring.UseTeamResource

-- GG
local GetUnitDistanceToPoint = GG.GetUnitDistanceToPoint
local DelayCall				 = GG.Delay.DelayCall

-- Constants
local GAIA_TEAM_ID = Spring.GetGaiaTeamID()
local BEACON_ID = UnitDefNames["beacon"].id
local BEACON_POINT_ID = UnitDefNames["beacon_point"].id
local UPLINK_ID = UnitDefNames["upgrade_uplink"].id
local GARRISON_ID = UnitDefNames["upgrade_garrison"].id
local DROPZONE_IDS = {}
GG.DROPZONE_IDS = DROPZONE_IDS

--local MIN_BUILD_RANGE = tonumber(UnitDefNames["beacon"].customParams.minbuildrange) or 230
local MAX_BUILD_RANGE = UnitDefs[GARRISON_ID].buildDistance
local RADIUS = 230

local DROPSHIP_DELAY = 10 * 30 -- 10s
local CMD_UPGRADE = GG.CustomCommands.GetCmdID("CMD_UPGRADE")

-- Variables
local towerDefIDs = {} -- towerDefIDs[unitDefID] = "turret" or "sensor"
local buildLimits = {} -- buildLimits[unitID] = {turret = 4, sensor = 1}
local towerOwners = {} -- towerOwners[towerID] = beaconID

local upgradeDefs = {} -- upgradeDefs[unitDefID] = {cmdDesc = {cmdDescTable}, cost = cost}
GG.outpostDefs = upgradeDefs -- TODO: check why this is in GG
local dropZoneDefs = {}

local upgradeCMDs = {} -- upgradeCMDs[cmdID] = unitDefID
local upgradePointIDs = {} -- upgradePointIDs[upgradeID] = upgradePointID
local upgradeIDs = {} -- upgradeIDs[beaconID] = upgradeID

local upgradePointBeaconIDs = {} -- upgradePointBeaconIDs[upgradePointID] = beaconID
local beaconUpgradePointIDs = {} -- beaconUpgradePointIDs[beaconID] = {upgradePointID1, upgradePointID2, upgradePointID3}

local dropZoneIDs = {} -- dropZoneIDs[teamID] = dropZoneID
local dropZoneBeaconIDs = {} -- dropZoneBeaconIDs[teamID] = beaconID
GG.dropZoneBeaconIDs = dropZoneBeaconIDs
local dropZoneCmdDesc

local hotSwapIDs = {} -- hotSwapIDs[unitID] = true
local function HotSwap(unitID, unitDefID, teamID)
	hotSwapIDs[unitID] = true
	local x,y,z = Spring.GetUnitPosition(unitID)
	if not Spring.GetUnitIsDead(unitID) then
		Spring.DestroyUnit(unitID, false, true)
		--Spring.Echo("Destroy:", unitID)
	end
	if not teamID then
		teamID = Spring.GetUnitTeam(unitID)
	end
	DelayCall(Spring.CreateUnit,{unitDefID, x,y,z, "s", teamID, false, false, unitID, nil}, 3) -- 3 frame delay appears to be minimum
end

local BEACON_POINT_DIST = 400
local function BeaconPoints(beaconID, teamID, x, y, z)
	beaconUpgradePointIDs[beaconID] = {}
	for i = 0, 2 do
		local angle = i * 2 * math.pi / 3
		local dx, dz = math.sin(angle) * BEACON_POINT_DIST, math.cos(angle) * BEACON_POINT_DIST
		local upgradePointID = CreateUnit(BEACON_POINT_ID, x + dx, y, z + dz, "s", teamID)
		upgradePointBeaconIDs[upgradePointID] = beaconID
		beaconUpgradePointIDs[beaconID][i+1] = upgradePointID
	end
end
GG.BeaconPoints = BeaconPoints

function gadget:GamePreload()
	for unitDefID, unitDef in pairs(UnitDefs) do
		local name = unitDef.name
		local cp = unitDef.customParams
		if cp and cp.baseclass == "tower" then -- automatically build table of towers
			towerDefIDs[unitDefID] = unitDef.weapons[1] and "turret" or "sensor"
		elseif name:find("dropzone") then -- check for dropzones first
			DROPZONE_IDS[unitDefID] = true
		elseif cp.baseclass == "upgrade" then -- automatically build beacon upgrade cmdDescs
			local cBillCost = unitDef.metalCost
			local upgradeCmdDesc = {
				id     = GG.CustomCommands.GetCmdID("CMD_UPGRADE_" .. name, cBillCost),
				type   = CMDTYPE.ICON,
				name   = unitDef.humanName:gsub(" ", "  \n"),
				action = 'upgrade',
				tooltip = "C-Bill cost: " .. cBillCost,
			}
			upgradeDefs[unitDefID] = {cmdDesc = upgradeCmdDesc, cost = cBillCost}
			upgradeCMDs[upgradeCmdDesc.id] = unitDefID
		end
	end
	GG.DROPZONE_IDS = DROPZONE_IDS
	dropZoneCmdDesc = {
		id     = GG.CustomCommands.GetCmdID("CMD_DROPZONE", 0), -- dropzone is free
		type   = CMDTYPE.ICON,
		name   = "Dropzone",
		action = 'dropzone',
		tooltip = "Set as primary dropzone",
	}
	for dropZoneDefID in pairs(DROPZONE_IDS) do
		dropZoneDefs[dropZoneDefID] = {cmdDesc = dropZoneCmdDesc, cost = 0}
	end
end

-- REGULAR UPGRADES

local function AddUpgradeOptions(unitID)
	if not Spring.ValidUnitID(unitID) then return end
	for upgradeDefID, upgradeInfo in pairs(upgradeDefs) do
		InsertUnitCmdDesc(unitID, upgradeInfo.cmdDesc)
	end
end

local function ToggleUpgradeOptions(unitID, on)
	if not Spring.ValidUnitID(unitID) then return end
	for upgradeDefID, upgradeInfo in pairs(upgradeDefs) do
		EditUnitCmdDesc(unitID, FindUnitCmdDesc(unitID, upgradeInfo.cmdDesc.id), {disabled = not on})
	end
	--EditUnitCmdDesc(unitID, FindUnitCmdDesc(unitID, dropZoneCmdDesc.id), {disabled = not on}) -- REMOVE
end
GG.ToggleUpgradeOptions = ToggleUpgradeOptions

function SpawnCargo(beaconID, targetID, dropshipID, unitDefID, teamID)
	local tx, ty, tz = GetUnitPosition(dropshipID)
	local cargoID = CreateUnit(unitDefID, tx, ty, tz, "s", teamID)
	env = Spring.UnitScript.GetScriptEnv(dropshipID)
	Spring.UnitScript.CallAsUnit(dropshipID, env.LoadCargo, cargoID, targetID, beaconID)
	-- extra behaviour to link outposts with beacons
	if upgradeDefs[unitDefID] then
		upgradePointIDs[cargoID] = targetID 
		upgradeIDs[targetID] = cargoID
		-- Let unsynced know about this pairing
		Spring.SetUnitRulesParam(cargoID, "beaconID", beaconID)
		Spring.SetUnitRulesParam(targetID, "upgradeID", cargoID)
	end
end

function SpawnDropship(beaconID, unitID, teamID, dropshipType, cargo, cost)
	--Spring.Echo("Spawn a dropship!", beaconID, unitID, teamID, dropshipType, cargo, cost)
	if Spring.ValidUnitID(unitID) and not Spring.GetUnitIsDead(unitID) and not upgradeIDs[unitID] and Spring.GetUnitTeam(unitID) == teamID then
		local tx,ty,tz = GetUnitPosition(unitID)
		local dropshipID = CreateUnit(dropshipType, tx, ty, tz, "s", teamID)
		--SendToUnsynced("VEHICLE_UNLOADED", dropshipID, teamID)
		if type(cargo) == "table" then
			for i, order in ipairs(cargo) do -- preserve order here
				for orderDefID, count in pairs(order) do
					for i = 1, count do
						DelayCall(SpawnCargo, {beaconID, unitID, dropshipID, orderDefID, teamID}, 1)
					end
				end
			end
		else
			DelayCall(SpawnCargo, {beaconID, unitID, dropshipID, cargo, teamID}, 1)
		end
	else -- dropzone moved or beacon was capped
		-- Refund
		Spring.AddTeamResource(teamID, "metal", cost)
	end
end

local beaconDropshipQueue = {} -- beaconDropshipQueue[beaconID] = {info1 = {}, info2 = {}, ...}

function EnqueueDropship(beaconID, beaconPointID, teamID, info)
	if not beaconDropshipQueue[beaconID] then beaconDropshipQueue[beaconID] = {} end -- TODO: move to unitcreated?
	table.insert(beaconDropshipQueue[beaconID], info)
	--Spring.Echo("Adding dropship ", info.dropshipType, " to beacon ", beaconID, beaconPointID, "(queue length " , (#beaconDropshipQueue[beaconID]), ")")
	-- If it's the first item in queue, start emptying
	if #beaconDropshipQueue[beaconID] == 1 then
		NextDropshipQueueItem(beaconID, teamID)
	end
end

function NextDropshipQueueItem(beaconID, teamID)
	if #beaconDropshipQueue[beaconID] > 0 then
		local item = beaconDropshipQueue[beaconID][1]
		if item.sound then
			GG.PlaySoundForTeam(teamID, item.sound, 1)
		end
		SpawnDropship(beaconID, item.target, teamID, item.dropshipType, item.cargo, item.cost)
	end
end

function DropzoneFree(beaconID, teamID)
	--Spring.Echo("DropzoneFree", beaconID, teamID)
	table.remove(beaconDropshipQueue[beaconID], 1)
	NextDropshipQueueItem(beaconID, teamID)
end
GG.DropzoneFree = DropzoneFree

function DropshipDelivery(beaconID, beaconPointID, teamID, dropshipType, cargo, cost, sound, delay)
	local info = {
		["target"] = beaconPointID, 
		["dropshipType"] = dropshipType, 
		["cargo"] = cargo, 
		["cost"] = cost, 
		["sound"] = sound
	}
	-- TODO: check dropshipType for mech deliveries and add to front of queue?
	DelayCall(EnqueueDropship, {beaconID, beaconPointID, teamID, info}, delay)
	if cost then -- deduct cost immediately to give feedback to player that order was accepted
	-- will be refunded later if it fails (e.g. beacon capped)
		--Spring.Echo("COST!?", cost)
		UseTeamResource(teamID, "metal", cost)
	end
end
GG.DropshipDelivery = DropshipDelivery

-- DROPZONE
local function SetDropZone(beaconID, teamID)
	local currDropZone = dropZoneIDs[teamID]
	if currDropZone then
		--ToggleUpgradeOptions(dropZoneBeaconIDs[teamID], true) -- REMOVE
		DestroyUnit(currDropZone, false, true)
		GG.DropshipLeft(teamID) -- reset the timer
	end
	local x,y,z = GetUnitPosition(beaconID)
	local side = GG.teamSide[teamID]
	local dropZoneID = CreateUnit(side .. "_dropzone", x,y,z, "s", teamID)
	dropZoneIDs[teamID] = dropZoneID
	dropZoneBeaconIDs[teamID] = beaconID
	Spring.SetUnitRulesParam(beaconID, "secure", 1)
end

-- TOWERS
function LimitTowerType(unitID, teamID, towerType, increase)	
	local towersRemaining = buildLimits[unitID][towerType]
	if increase then
		buildLimits[unitID][towerType] = towersRemaining + 1
		for tDefID, tType in pairs(towerDefIDs) do
			if tType == towerType then
				local cmdDescID = FindUnitCmdDesc(unitID, -tDefID)
				if cmdDescID then
					EditUnitCmdDesc(unitID, cmdDescID, {disabled = false, params = {}})
				end
			end
		end
	elseif towersRemaining == 0 then 
		Spring.SendMessageToTeam(teamID, "Limit reached for " .. towerType)
		return false 
	else
		buildLimits[unitID][towerType] = towersRemaining - 1
		if towersRemaining == 1 then
			for tDefID, tType in pairs(towerDefIDs) do
				if tType == towerType then
					EditUnitCmdDesc(unitID, FindUnitCmdDesc(unitID, -tDefID), {disabled = true, params = {"L"}})
				end
			end
		end
		return true
	end
end

function gadget:UnitCreated(unitID, unitDefID, teamID, builderID)
	hotSwapIDs[unitID] = nil
	local unitDef = UnitDefs[unitDefID]
	local cp = unitDef.customParams
	if unitDefID == BEACON_ID then
		InsertUnitCmdDesc(unitID, dropZoneCmdDesc)
	elseif unitDefID == BEACON_POINT_ID then
		AddUpgradeOptions(unitID)
	elseif unitDefID == UPLINK_ID then
		buildLimits[unitID] = {["sensor"] = 4}
	elseif unitDefID == GARRISON_ID then
		buildLimits[unitID] = {["turret"] = 4}
	elseif cp and cp.baseclass == "tower" then
		-- track creation of turrets and their originating beacons so we can give back slots if a turret dies
		if builderID then -- ignore /give turrets
			towerOwners[unitID] = builderID
		end
	end
end

function gadget:UnitDestroyed(unitID, unitDefID, teamID)
	local towerOwnerID = towerOwners[unitID]
	if towerOwnerID then -- unit was a turret with owning beacon, open the slot back up
		local towerType = towerDefIDs[unitDefID]
		LimitTowerType(towerOwnerID, teamID, towerType, true) -- increase limit
		towerOwners[unitID] = nil
	end
	if DROPZONE_IDS[unitDefID] then -- unit was a team's dropzone, reset upgrade options
		--ToggleUpgradeOptions(dropZoneBeaconIDs[teamID], true) -- REMOVE
		dropZoneIDs[teamID] = nil
		dropZoneBeaconIDs[teamID] = nil
	elseif upgradeDefs[unitDefID] then
		local upgradePointID = upgradePointIDs[unitID]
		if upgradePointID then -- beaconID can be nil if /give testing
			GG.Delay.DelayCall(SetUnitRulesParam, {unitID, "beaconID", ""}, 5) -- delay for safety
			env = Spring.UnitScript.GetScriptEnv(upgradePointID)
			Spring.UnitScript.CallAsUnit(upgradePointID, env.ChangeType, false)
			upgradePointIDs[unitID] = nil
			upgradeIDs[upgradePointID] = nil
			-- Re-add upgrade options to beacon
			ToggleUpgradeOptions(upgradePointID, true)
		end
	end
end


local lastDamaged = {} -- lastDamaged[unitID] = lastDamagedFrame
local MIN_LAST_DAMAGED = 20 * 30 -- 20s
function gadget:UnitDamaged(unitID, unitDefID, teamID, damage)
	local cp = UnitDefs[unitDefID].customParams
	if cp.baseclass == "upgrade" then -- unit is an upgrade 
		local lastDamagedFrame = lastDamaged[unitID] or 0
		local currFrame = GetGameFrame()
		local name = UnitDefs[unitDefID].name
		if lastDamagedFrame < currFrame - MIN_LAST_DAMAGED then
			lastDamaged[unitID] = currFrame
			GG.PlaySoundForTeam(teamID, "BB_" .. name .. "_UnderAttack", 1)
		end
	end
end

function gadget:UnitGiven(unitID, unitDefID, newTeam, oldTeam)
	if unitDefID == BEACON_ID then
		for i, upgradePointID in pairs(beaconUpgradePointIDs[unitID]) do			
			DelayCall(TransferUnit, {upgradePointID, newTeam}, 1)
			--DelayCall(SetUnitNeutral,{upgradePoint, newTeam == GAIA_TEAM_ID}, 2) -- REMOVE
		end
		if dropZoneBeaconIDs[oldTeam] == unitID and oldTeam ~= GAIA_TEAM_ID then
			local dropZoneID = dropZoneIDs[oldTeam]
			Spring.DestroyUnit(dropZoneID, false, true)
			if newTeam == GAIA_TEAM_ID then -- dropzone given on team death, 
				-- will be destroyed next frame but needs beaconID in UnitDestroyed
				dropZoneBeaconIDs[newTeam] = unitID
			end
		end
	elseif unitDefID == UPLINK_ID or unitDefID == GARRISON_ID then
		for towerID, beaconID in pairs(towerOwners) do
			if beaconID == unitID then
				DelayCall(TransferUnit, {towerID, newTeam}, 1)
				local env = Spring.UnitScript.GetScriptEnv(towerID)
				Spring.UnitScript.CallAsUnit(towerID, env.TeamChange, newTeam)
				DelayCall(SetUnitNeutral,{towerID, newTeam == GAIA_TEAM_ID}, 2)
			end
		end
	end
end

function gadget:AllowCommand(unitID, unitDefID, teamID, cmdID, cmdParams, cmdOptions)
	if unitDefID == BEACON_ID then
		if cmdID == dropZoneCmdDesc.id then
			if Spring.GetUnitRulesParam(unitID, "secure") == 0 then 
				Spring.SendMessageToTeam(teamID, "Cannot establish dropzone - Under attack!")
				return false 
			end
			--ToggleUpgradeOptions(unitID, false) -- REMOVE
			SetDropZone(unitID, teamID)
		end
	elseif unitDefID == BEACON_POINT_ID then
		if upgradeCMDs[cmdID] and not upgradeIDs[unitID] then
			if Spring.GetUnitRulesParam(unitID, "secure") == 0 then 
				Spring.SendMessageToTeam(teamID, "Cannot upgrade beacon - Under attack!")
				return false 
			end
			local upgradeDefID = upgradeCMDs[cmdID]
			local cost = upgradeDefs[upgradeDefID] and upgradeDefs[upgradeDefID].cost or 1000
			if cost <= GetTeamResources(teamID, "metal") then
				--Spring.Echo("I'm totally gonna upgrade your beacon bro!")
				ToggleUpgradeOptions(unitID, false)
				DropshipDelivery(upgradePointBeaconIDs[unitID], unitID, teamID, "is_avenger", upgradeDefID, cost, "BB_Dropship_Inbound", DROPSHIP_DELAY)
			else
				GG.PlaySoundForTeam(teamID, "BB_Insufficient_Funds", 1)
			end
		elseif cmdID == CMD.SELFD then -- Disallow self-d
			return false
		end	
	elseif unitDefID == UPLINK_ID or unitDefID == GARRISON_ID then
		if cmdID < 0 then
			local towerType = towerDefIDs[-cmdID]
			if not towerType then return false end
			if unitDefID == GARRISON_ID then -- Garrison has limited build radius
				local tx, ty, tz = unpack(cmdParams)
				local dist = GetUnitDistanceToPoint(unitID, tx, ty, tz, false)
				--[[if dist < MIN_BUILD_RANGE then
					Spring.SendMessageToTeam(teamID, "Too close to beacon")
					return false
				else]]
				if dist > MAX_BUILD_RANGE then
					Spring.SendMessageToTeam(teamID, "Too far from garrison!")
					return false
				end
			end
			return LimitTowerType(unitID, teamID, towerType)
		end
	elseif UnitDefs[unitDefID].customParams.decal then
		return false -- disallow all commands to decals
	end
	return true
end

function gadget:Initialize()
	gadget:GamePreload()
	for _,unitID in ipairs(Spring.GetAllUnits()) do
		local teamID = Spring.GetUnitTeam(unitID)
		local unitDefID = Spring.GetUnitDefID(unitID)
		if DROPZONE_IDS[unitDefID] then
			Spring.DestroyUnit(unitID, false, true)
		else
			gadget:UnitCreated(unitID, unitDefID, teamID)
		end
	end
end

else
--	UNSYNCED

-- localisations
local GetUnitRulesParam			= Spring.GetUnitRulesParam
-- SyncedRead
local GetGameFrame				= Spring.GetGameFrame
-- UnsyncedRead
local GetSelectedUnitsSorted	= Spring.GetSelectedUnitsSorted
-- UnsyncedCtrl
local SelectUnitArray			= Spring.SelectUnitArray
-- variables
local outpostDefIDs = {}
for unitDefID, unitDef in pairs(UnitDefs) do
	local cp = unitDef.customParams
	if cp and cp.baseclass == "upgrade" then
		outpostDefIDs[unitDefID] = true
	end
end
local lastFrame = 0

function gadget:Update()
	local frameNum = Spring.GetGameFrame()
	if lastFrame == frameNum then
		return --same frame
	end
	lastFrame = frameNum
	--Spring.Echo("unsynced gameframe: " .. lastFrame)
	local selected = GetSelectedUnitsSorted()
	for unitDefID, units in pairs(selected) do
		if outpostDefIDs[unitDefID] then
			for _, unitID in pairs(units) do
				SelectUnitArray({GetUnitRulesParam(unitID, "beaconID")}, true)
			end
		end
	end
end

end
