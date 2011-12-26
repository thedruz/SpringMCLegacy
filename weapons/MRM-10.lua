weaponDef = {
	name                    = "Medium Range Missile 10",
	weaponType              = "MissileLauncher",
	renderType				= 1,
	explosionGenerator    	= "custom:HE_MEDIUM",
--	cegTag					= "BazookaTrail",
	smokeTrail				= true,
	smokeDelay				= "0.05",
	soundHit              	= [[GEN_Explode1]],
	soundStart            	= [[MRM_Fire]],
--	soundTrigger			= 0,
	burnblow				= true, 	--Bullets explode at range limit.
	collideFriendly			= true,
	noSelfDamage            = true,
	turret                  = true,
	range                   = 1500,
	accuracy                = 1000,
	wobble					= 1300,
	dance					= 100,
	guidance				= true,
	selfprop				= true,
	ballistic				= true,
	trajectoryHeight		= 0.1,
	tracks					= false,
	turnRate				= 5000,
	weaponTimer				= 5,
	areaOfEffect            = 20,
	startVelocity			= 750,
	weaponVelocity          = 1000,
	reloadtime              = 10,
	burst					= 10,
	burstrate				= 0.1,
	model					= "Missile.s3o",
	interceptedByShieldType	= 32,
	damage = {
		default = 100,--10 DPS
	},
	customparams = {
		heatgenerated		= "40",--4/sec
		cegflare			= "MISSILE_MUZZLEFLASH",
    },
}

return lowerkeys({ MRM10 = weaponDef })