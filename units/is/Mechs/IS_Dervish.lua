local IS_Dervish = Medium:New{
	corpse				= "IS_Dervish_X",
	maxDamage           = 12000,
	mass                = 5500,
	buildCostEnergy     = 55,
	buildCostMetal        = 0,--      = 21100,
	maxVelocity		= 4, --80kph/20

	customparams = {
		torsoturnspeed	= "160",
    },
}
	
local DV6M = IS_Dervish:New{
	name              	= "Dervish DV-6M",
	description         = "Medium-class Missile Support",
	objectName        	= "IS_Dervish_DV6M.s3o",
	weapons = {	
		[1] = {
			name	= "LRM10",
			OnlyTargetCategory = "notbeacon",
		},
		[2] = {
			name	= "LRM10",
			OnlyTargetCategory = "notbeacon",
		},
		[3] = {
			name	= "MBL",
			OnlyTargetCategory = "notbeacon",
		},
		[4] = {
			name	= "MBL",
			OnlyTargetCategory = "notbeacon",
		},
		[5] = {
			name	= "SRM2",
			OnlyTargetCategory = "notbeacon",
		},
		[6] = {
			name	= "SRM2",
			OnlyTargetCategory = "notbeacon",
		},
	},
		
	customparams = {
		helptext		= "Armament: 2 x LRM-10, 2 x Medium Laser, 2 x SRM-2 - Armor: 7.5 tons Standard",
		heatlimit		= "10",
		maxammo 		= {lrm = 360, srm = 240},
    },
}

local DV8D = IS_Dervish:New{
	name              	= "Dervish DV-8D",
	description         = "Medium-class Missile Support",
	objectName        	= "IS_Dervish_DV8D.s3o",
	weapons = {	
		[1] = {
			name	= "LRM15",
			OnlyTargetCategory = "notbeacon",
		},
		[2] = {
			name	= "LRM15",
			OnlyTargetCategory = "notbeacon",
		},
		[3] = {
			name	= "ERMBL",
			OnlyTargetCategory = "notbeacon",
		},
		[4] = {
			name	= "ERMBL",
			OnlyTargetCategory = "notbeacon",
		},
		[5] = {
			name	= "ERMBL",
			OnlyTargetCategory = "notbeacon",
		},
		[6] = {
			name	= "ERMBL",
			OnlyTargetCategory = "notbeacon",
		},
	},
		
    customparams = {
		helptext		= "Armament: 2 x LRM-15, 4 x ER Medium Laser,  - Armor: 10.5 tons Standard",
		heatlimit		= "20",
		maxammo 		= {lrm = 720},
    },
}

return lowerkeys({ 
	["IS_Dervish_DV6M"] = DV6M,
	["IS_Dervish_DV8D"] = DV8D,
})