local Battlehawk = Light:New{
	name              	= "Battle Hawk",
	customparams = {
		cockpitheight	= 46,
		tonnage			= 30,
    },
}

local BHK305 = Battlehawk:New{
	description         = "Light Skirmisher",
	weapons = {	
		[1] = {
			name	= "MPL",
		},
		[2] = {
			name	= "MPL",
		},
		[3] = {
			name	= "MPL",
		},
		[4] = {
			name	= "SSRM2",
		},
		[5] = {
			name	= "AMS",
		},
	},
		
	customparams = {
		variant         = "BH-K305",
		speed			= 80,
		price			= 7710,
		heatlimit 		= 22,
		armor			= {type = "ferro", tons = 5.5},
		jumpjets		= 5,
		maxammo 		= {srm = 2},
    },
}

return lowerkeys({
	["LA_Battlehawk_BHK305"] = BHK305:New(),
})