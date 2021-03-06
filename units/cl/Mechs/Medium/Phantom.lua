local Phantom = Medium:New{
	name				= "Phantom",
	
	customparams = {
		tonnage			= 45,
    },
}
	
local Prime = Phantom:New{
	description         = "Medium EWAR Support",
	weapons	= {	
		[1] = {
			name	= "CERMBL",
		},
		[2] = {
			name	= "LRM5",
		},
		[3] = {
			name	= "CERSBL",
		},
		[4] = {
			name	= "TAG",
		},
	},
	customparams = {
		variant         = "Prime",
		speed			= 140,
		price			= 11590,
		heatlimit 		= 24,
		armor			= {type = "ferro", tons = 6},
		maxammo 		= {lrm = 1},
		bap				= true,
		ecm				= true,
    },
}

local B = Phantom:New{
	description         = "Medium Skirmisher",
	weapons	= {	
		[1] = {
			name	= "SRM4",
		},
		[2] = {
			name	= "SRM4",
		},
		[3] = {
			name	= "CERSBL",
		},
		[4] = {
			name	= "CERMBL",
		},
	},
	customparams = {
		variant         = "B",
		speed			= 140,
		price			= 10960,
		heatlimit 		= 24,
		armor			= {type = "ferro", tons = 6},
		maxammo 		= {srm = 2},
    },
}

return lowerkeys({
	["WF_Phantom_Prime"] = Prime:New(),
	["WF_Phantom_B"] = B:New(),
})