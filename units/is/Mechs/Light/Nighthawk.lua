local Nighthawk = Light:New{
	name				= "Nighthawk",
	
	customparams = {
		cockpitheight	= 43,
		tonnage			= 35,
    },
}

local NTK2Q = Nighthawk:New{
	description         = "Light Striker",
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
		variant         = "NTK-2Q",
		speed			= 90,
		price			= 9970,
		heatlimit 		= 24,
		armor			= {type = "standard", tons = 7},
    },
}

local NTK2S = Nighthawk:New{
	description         = "Light Striker",
	weapons	= {	
		[1] = {
			name	= "ERLBL",
		},
		[2] = {
			name	= "LBL",
		},
	},
		
	customparams = {
		variant         = "NTK-2S",
		speed			= 90,
		price			= 10170,
		heatlimit 		= 22,
		armor			= {type = "standard", tons = 7},
		bap				= true,
		ecm				= true,
    },
}

return lowerkeys({
	--["LA_Nighthawk_NTK2Q"] = NTK2Q:New(),
	["LA_Nighthawk_NTK2S"] = NTK2S:New(),
})