local Upgrade_TurretControl = Upgrade:New{
	name              	= "A.I. Turret Control",
	description         = "Automated Turret Control Station",
	maxDamage           = 10000,
	mass                = 5000,
	buildCostMetal      = 7000,

	collisionVolumeScales = [[25 25 25]],

	-- Constructor stuff
	builder				= true,
	builddistance 		= 1000000,
	workerTime			= 10, -- ?	
	terraformSpeed		= 10000,
	showNanoSpray		= false,
	
	customparams = {
		helptext		= "Ping Pong Potato",
    },
}

return lowerkeys({ ["Upgrade_TurretControl"] = Upgrade_TurretControl })