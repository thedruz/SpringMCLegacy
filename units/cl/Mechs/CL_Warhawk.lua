local CL_Warhawk = Assault:New{
	corpse				= "CL_Warhawk_X",
	sightDistance       = 1200,
	radarDistance      	= 2000,
	maxDamage           = 25900,
	mass                = 8500,
	buildCostEnergy     = 85,
	buildCostMetal      = 39900,
	maxVelocity		= 3.2, --64kph/10/2
	maxReverseVelocity= 1.6,
	acceleration    = 1.0,
	brakeRate       = 0.15,
	turnRate 		= 700,
	
	customparams = {
		heatlimit		= 50,
		torsoturnspeed	= 100,
    },
}
	
local Prime = CL_Warhawk:New{
	name              	= "War Hawk (Masakari)",
	description         = "Assault-class Sniper Mech",
	objectName        	= "CL_Warhawk.s3o",
	weapons	= {	
		[1] = {
			name	= "CERPPC",
		},
		[2] = {
			name	= "CERPPC",
		},
		[3] = {
			name	= "CERPPC",
		},
		[4] = {
			name	= "CERPPC",
		},
		[5] = {
			name	= "ATM6",
		},
	},

	customparams = {
		helptext		= "Armament: 4 x ER Particle Cannon, 1 x ATM-9 - Armor: 13.5 tons Ferro-Fibrous",
    },
}

return lowerkeys({
	["CL_Warhawk_Prime"] = Prime,
})