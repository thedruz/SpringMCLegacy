local Nighthawk = Light:New{
	name				= "Nighthawk",
	
	customparams = {
		tonnage			= 35,
    },
}

local NTK2Q = Nighthawk:New{
	description         = "Light Fire Support",
	weapons	= {	
		[1] = {
			name	= "ERLBL",
		},
		[2] = {
			name	= "LBL",
		},
		[3] = {
			name	= "MPL",
			OnlyTargetCategory = "ground",
		},
	},
		
	customparams = {
		variant         = "NTK2Q",
		speed			= 90,
		price			= 15500,
		heatlimit 		= 10,
		armor			= {type = "standard", tons = 7},
    },
}

local NTK2S = Nighthawk:New{
	description         = "Light EWAR",
	weapons	= {	
		[1] = {
			name	= "ERLBL",
		},
		[2] = {
			name	= "LBL",
		},
	},
		
	customparams = {
		variant         = "NTK2S",
		speed			= 90,
		price			= 15500,
		heatlimit 		= 10,
		armor			= {type = "standard", tons = 7},
		bap				= true,
		ecm				= true,
    },
}

return lowerkeys({
	["LA_Nighthawk_NTK2Q"] = NTK2Q:New(),
	["LA_Nighthawk_NTK2S"] = NTK2S:New(),
})