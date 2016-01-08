local HeavyAPC = LightTank:New{
	name              	= "Heavy APC",
	name				= "Troop Transport",
	trackWidth			= 18,--width to render the decal
	
	weapons 		= {	
		[1] = {
			name	= "MG",
			maxAngleDif = 30,
		},
		[2] = {
			name	= "MG",
			maxAngleDif = 30,
		},
	},
	
	customparams = {
		tonnage			= 20,
		variant         = "",
		speed			= 80,
		price			= 4130,
		heatlimit 		= 10,
		armor			= {type = "standard", tons = 4},
		barrelrecoildist = {[1] = 4},
		squadsize 		= 2,
    },
}

return lowerkeys({
	["CC_HeavyAPC"] = HeavyAPC:New(),
	["DC_HeavyAPC"] = HeavyAPC:New(),
	["FW_HeavyAPC"] = HeavyAPC:New(),
	["FS_HeavyAPC"] = HeavyAPC:New(),
	["LA_HeavyAPC"] = HeavyAPC:New(),
})