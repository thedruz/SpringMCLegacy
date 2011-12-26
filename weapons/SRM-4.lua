weaponDef = {
	name                    = "Short Range Missile 4",
	weaponType              = "MissileLauncher",
	renderType				= 1,
	explosionGenerator    	= "custom:HE_MEDIUM",
--	cegTag					= "BazookaTrail",
	smokeTrail				= true,
	smokeDelay				= "0.05",
	soundHit              	= [[GEN_Explode3]],
	soundStart            	= [[SRM_Fire]],
--	soundTrigger			= 0,
	burnblow				= true, 	--Bullets explode at range limit.
	collideFriendly			= true,
	noSelfDamage            = true,
	turret                  = true,
	range                   = 600,
	accuracy                = 100,
	wobble					= 900,
	dance					= 65,
	guidance				= true,
	selfprop				= true,
	lineOfSight				= true,
	tracks					= true,
	turnRate				= 4000,
	weaponTimer				= 5,
	areaOfEffect            = 20,
	startVelocity			= 700,
	weaponVelocity          = 900,
	reloadtime              = 5,
	burst					= 4,
	burstrate				= 0.1,
	sprayAngle 				= 100,
	model					= "Missile.s3o",
	interceptedByShieldType	= 32,
	damage = {
		default = 100,--10 DPS
	},
	customparams = {
		heatgenerated		= "15",--3/sec
		cegflare			= "MISSILE_MUZZLEFLASH",
    },
}

return lowerkeys({ SRM4 = weaponDef })