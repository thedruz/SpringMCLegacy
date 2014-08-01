local MRM_Class = Weapon:New{
	weaponType              = "MissileLauncher",
	explosionGenerator    	= "custom:HE_SMALL",
	cegTag					= "MRMTrail",
	smokeTrail				= false,
	soundHit              	= "MRM_Hit",
	soundStart            	= "MRM_Fire",
	burnblow				= true, 	--Bullets explode at range limit.
	collideFriendly			= true,
	noSelfDamage            = true,
	turret                  = true,
	range                   = 1500,
	accuracy                = 100,
	sprayAngle				= 400,
	weaponTimer				= 5,
	areaOfEffect            = 20,
	startVelocity			= 900,
	weaponVelocity          = 900,
	reloadtime              = 10,
	burstrate				= 0.1,
	model					= "Missile.s3o",
	damage = {
		default = 100,--10 DPS
	},
	customparams = {
		cegflare			= "MISSILE_MUZZLEFLASH",
		weaponclass			= "missile",
		jammable			= false,
		ammotype			= "mrm",
    },
}

local MRM10 = MRM_Class:New{
	name                    = "MRM-10",
	burst					= 10,
	customparams = {
		heatgenerated		= "40",--4/sec
	}
}

local MRM20 = MRM_Class:New{
	name                    = "MRM-20",
	burst					= 20,
	customparams = {
		heatgenerated		= "60",--4/sec
    },
}

return lowerkeys({ 
	MRM10 = MRM10,
	MRM20 = MRM20,
})