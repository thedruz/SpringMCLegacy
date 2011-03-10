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
-- Synced Read
local GetUnitPieceMap		= Spring.GetUnitPieceMap
-- Synced Ctrl

-- Unsynced Ctrl
-- Constants

-- Variables

function gadget:UnitCreated(unitID, unitDefID, teamID, builderID)
	-- Parse Model Data
	local pieceMap = GetUnitPieceMap(unitID)
end

function gadget:GamePreload()
	-- Parse UnitDef Data
	for unitDefID, unitDef in pairs(UnitDefs) do
		local info = {}
		local weapons = unitDef.weapons
		
		-- Parse UnitDef Weapon Data
		local missileWeaponIDs = {}
		local burstLengths = {}
		local firingHeats = {}
		for i = 1, #weapons do
			local weaponInfo = weapons[i]
			--for tag, value in pairs(weaponInfo) do
				--Spring.Echo(tag, value)
			--end
			local weaponDef = WeaponDefs[weaponInfo.weaponDef]
			burstLengths[i] = weaponDef.salvoSize
			firingHeats[i] = weaponDef.customParams.heatgenerated or 0
			if weaponDef.type == "MissileLauncher" then
				missileWeaponIDs[i] = true
			end
		end
		-- UnitDef Level Info
		info.heatLimit = (unitDef.customParams.heatlimit or 50) * 10
		info.coolRate = info.heatLimit / 10 -- or a constant rate of 10?
		info.numWeapons = #weapons
		-- WeaponDef Level Info
		info.missileWeaponIDs = missileWeaponIDs
		info.burstLengths = burstLengths
		info.firingHeats = firingHeats
		GG.lusHelper[unitDefID] = info
	end
	
end

else

-- UNSYNCED

end
