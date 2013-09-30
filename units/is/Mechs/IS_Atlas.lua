local IS_Atlas = Assault:New{
	corpse				= "IS_Atlas_X",
	maxDamage           = 30400,
	mass                = 10000,
	buildCostEnergy     = 100, -- in tons
	buildCostMetal        = 0,--      = 38600,
	maxVelocity		= 2.5, --50kph/20
		
    customparams = {
		heatlimit		= "20",
		torsoturnspeed	= "100",
    },
}

local AS7D = IS_Atlas:New{
	name              	= "Atlas AS7-D",
	description         = "Assault-class Close Range Brawler",
	objectName        	= "IS_Atlas_AS7D.s3o",
	weapons 		= {	
		[1] = {
			name	= "AC20",
			OnlyTargetCategory = "ground",
		},
		[2] = {
			name	= "MBL",
			OnlyTargetCategory = "notbeacon",
		},
		[3] = {
			name	= "MBL",
			OnlyTargetCategory = "notbeacon",
		},
		[4] = {
			name	= "MBL",
			OnlyTargetCategory = "ground",
		},
		[5] = {
			name	= "MBL",
			OnlyTargetCategory = "ground",
		},
		[6] = {
			name	= "LRM10",
			OnlyTargetCategory = "notbeacon",
		},
		[7] = {
			name	= "LRM10",
			OnlyTargetCategory = "notbeacon",
		},
		[8] = {
			name	= "SRM6",
			OnlyTargetCategory = "notbeacon",
		},
	},
    customparams = {
		helptext		= "Armament: 1 x AC/20, 4 x Medium Beam Laser, 2 x LRM-10, 1 x SRM-6 - Armor: 19 tons Standard",
		maxammo 		= {lrm = 360, srm = 120, ac20 = 15},
    },
}

local AS7K = IS_Atlas:New{
	name              	= "Atlas AS7-K",
	description         = "Assault-class Long Range Fire Support",
	objectName        	= "IS_Atlas_AS7K.s3o",
	weapons 		= {	
		[1] = {
			name	= "Gauss",
			OnlyTargetCategory = "ground",
		},
		[2] = {
			name	= "ERLBL",
			OnlyTargetCategory = "notbeacon",
			SlaveTo = 1,
		},
		[3] = {
			name	= "ERLBL",
			OnlyTargetCategory = "notbeacon",
			SlaveTo = 1,
		},
		[4] = {
			name	= "MPL",
			OnlyTargetCategory = "ground",
			SlaveTo = 1,
		},
		[5] = {
			name	= "MPL",
			OnlyTargetCategory = "ground",
			SlaveTo = 1,
		},
		[6] = {
			name	= "LRM10",
			OnlyTargetCategory = "notbeacon",
			SlaveTo = 1,
		},
		[7] = {
			name	= "LRM10",
			OnlyTargetCategory = "notbeacon",
			SlaveTo = 1,
		},
		[8] = {
			name	= "AMS",
		},
	},
    customparams = {
		helptext		= "Armament: 1 x Gauss, 2 x Large Beam Laser, 2 x Medium Pulse Laser, 2 x LRM-10, AMS - Armor: 19 tons Standard",
		maxammo 		= {lrm = 360, gauss = 20},
    },
}

return lowerkeys({
	IS_Atlas_AS7D = AS7D,
	IS_Atlas_AS7K = AS7K,
})