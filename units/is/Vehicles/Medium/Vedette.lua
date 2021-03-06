local Vedette = LightTank:New{
	name              	= "Vedette",
	trackWidth			= 23,--width to render the decal
	
	customparams = {
		tonnage			= 50,
    },
}

local VedetteUAC = Vedette:New{
	description         = "Medium Striker Tank",
	
	weapons	= {	
		[1] = {
			name	= "UAC5",
		},
		[2] = {
			name	= "MG",
		},
	},
	
	customparams = {
		variant         = "",
		speed			= 80,
		price			= 4080,
		heatlimit 		= 10,
		armor			= {type = "ferro", tons = 5.5},
		maxammo 		= {ac5 = 4},
		barrelrecoildist = {[1] = 5},
		squadsize 		= 2,
    },
}

local VedetteLBX = Vedette:New{
	description         = "Medium Striker Tank",
	
	weapons	= {	
		[1] = {
			name	= "LBX5",
		},
		[2] = {
			name	= "MG",
		},
	},
	
	customparams = {
		variant         = "(Liao)",
		speed			= 80,
		price			= 4080,
		heatlimit 		= 10,
		armor			= {type = "ferro", tons = 6.5},
		maxammo 		= {ac5 = 4},
		barrelrecoildist = {[1] = 5},
		squadsize 		= 2,
		replaces		= "cc_vedette",
    },
}

local VedetteLG = Vedette:New{
	description         = "Medium Sniper Tank",
	
	weapons	= {	
		[1] = {
			name	= "LightGauss",
		},
	},
	
	customparams = {
		variant         = "(Marik)",
		speed			= 80,
		price			= 10280,
		heatlimit 		= 10,
		armor			= {type = "ferro", tons = 4},
		maxammo 		= {ltgauss = 4},
		barrelrecoildist = {[1] = 7},
		squadsize 		= 1,
		replaces		= "fw_vedette",
    },
}
	
return lowerkeys({
	["DC_Vedette"] = VedetteUAC:New(),
	["FS_Vedette"] = VedetteUAC:New(),
	["LA_Vedette"] = VedetteUAC:New(),
	["CC_Vedette"] = VedetteUAC:New(),
	["CC_VedetteLBX"] = VedetteLBX:New(),
	["FW_Vedette"] = VedetteUAC:New(),
	--["FW_VedetteLG"] = VedetteLG:New(),
})