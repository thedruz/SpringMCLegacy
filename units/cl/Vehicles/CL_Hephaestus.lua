local CL_Hephaestus = {
	name              	= "Hephaestus",
	description         = "Light Scout Hovercraft",
	objectName        	= "CL_Hephaestus.s3o",
	script				= "Vehicle.lua",
	corpse				= "CL_Hephaestus_X",
	explodeAs          	= "mechexplode",
	category 			= "tank ground hovercraft notbeacon",
	stealth				= 1,
	sightDistance       = 1200,
	radarDistance      	= 2000,
		stealth				= 1,
		activateWhenBuilt   = true,
		onoffable           = true,
		radarDistanceJam    = 500,
	maxDamage           = 8900,
	mass                = 3000,
	footprintX			= 2,
	footprintZ 			= 2,
	collisionVolumeType = "box",
	collisionVolumeScales = "18 15 40",
	collisionVolumeOffsets = "0 3 0",
	collisionVolumeTest = 1,
	buildCostEnergy     = 30,
	buildCostMetal      = 650,
	buildTime           = 0,
	canMove				= true,
	canHover			= true,
		movementClass   = "HOVER",
		maxVelocity		= 4.3, --130kph/30
		maxReverseVelocity= 4.05,
		acceleration    = .85,
		brakeRate       = 0.1,
		turnRate 		= 450,
	
	canAttack 			= true,
		--Makes unit use weapon from /weapons folder
		weapons 		= {	
			[1] = {
				name	= "CERMBL",
				OnlyTargetCategory = "notbeacon",
			},
			[2] = {
				name	= "CERMBL",
				OnlyTargetCategory = "notbeacon",
				WeaponSlaveTo = 1,
			},
			[3] = {
				name	= "NARC",
				OnlyTargetCategory = "notbeacon",
				WeaponSlaveTo = 1,
			},
		},
	customparams = {
		hasturnbutton	= "1",
		helptext		= "Armament: 2 x Medium Pulse Laser, 1 x NARC Launcher - Armor: 5 tons",
		heatlimit		= "20",
		unittype		= "vehicle",
		turretturnspeed = "75",
		elevationspeed  = "200",
    },
}

return lowerkeys({ ["CL_Hephaestus"] = CL_Hephaestus })