local Manticore = Tank:New{
	name              	= "Manticore",
	description         = "Heavy Striker Tank",
	
	trackWidth			= 23,--width to render the decal
	
	weapons	= {	
		[1] = {
			name	= "PPC",
		},
		[2] = {
			name	= "MBL",
		},
		[3] = {
			name	= "LRM10",
		},
		[4] = {
			name	= "SRM6",
		},
	},
	
	customparams = {
		tonnage			= 60,
		variant         = "",
		speed			= 60,
		price			= 7050,
		heatlimit 		= 10,
		armor			= {type = "standard", tons = 10},
		maxammo 		= {lrm = 1, srm = 1},
		barrelrecoildist = {[1] = 5},
		squadsize 		= 1,
    },
}

local ManticoreD = Manticore:New{
	description         = "Heavy Brawler Tank",
	
	weapons	= {	
		[1] = {
			name	= "LBX10",
		},
		[2] = {
			name	= "MPL",
		},
		[3] = {
			name	= "SSRM6",
		},
	},
	
	customparams = {
		variant         = "D",
		speed			= 60,
		price			= 8000,
		heatlimit 		= 10,
		armor			= {type = "ferro", tons = 10},
		maxammo 		= {ac10 = 2, srm = 1},
		barrelrecoildist = {[1] = 5},
		squadsize 		= 1,
    },
}

local ManticoreS = Manticore:New{
	description         = "Heavy Brawler Tank",
	
	weapons	= {	
		[1] = {
			name	= "LPL",
		},
		[2] = {
			name	= "SSRM2",
		},
		[3] = {
			name	= "LRM10",
		},
		[4] = {
			name	= "SRM6",
		},
	},
	
	customparams = {
		variant         = "S",
		speed			= 80,
		price			= 8000,
		heatlimit 		= 10,
		armor			= {type = "ferro", tons = 10},
		maxammo 		= {lrm = 1, srm = 1},
		squadsize 		= 1,
    },
}
	
return lowerkeys({
	["CC_Manticore"] = Manticore:New(),
	["DC_Manticore"] = Manticore:New(),
	["FS_Manticore"] = Manticore:New(),
	["FS_ManticoreD"] = ManticoreD:New(),
	["FW_Manticore"] = Manticore:New(),
	["LA_Manticore"] = Manticore:New(),
	["LA_ManticoreS"] = ManticoreS:New(),
})