weaponDef = {
	name                    = "Long Range Missile 15",
	weaponType              = "MissileLauncher",
	renderType				= 1,
	explosionGenerator    	= "custom:HE_SMALL",
	cegTag					= "LRMTrail",
	smokeTrail				= false,
	smokeDelay				= "0.05",
	soundHit              	= [[LRM_Hit]],
	soundStart            	= [[LRM_Fire]],
--	soundTrigger			= 0,
	burnblow				= false, 	--Bullets explode at range limit.
	collideFriendly			= true,
	noSelfDamage            = true,
--	canAttackGround			= false,
	turret                  = true,
	range                   = 3000,
	accuracy                = 2000,
	sprayangle				= 5000,
	wobble					= 2000,
	dance 					= 100,
	guidance				= true,
	selfprop				= true,
	ballistic				= false,
	trajectoryHeight		= 1,
	tracks					= true,
	turnRate				= 2500,
	flightTime				= 10,
	weaponTimer				= 20,
	areaOfEffect            = 20,
	startVelocity			= 600,
	weaponVelocity          = 800,
	reloadtime              = 15,
	burst					= 15,
	burstrate				= 0.1,
	model					= "Missile.s3o",
	interceptedByShieldType	= 32,
	damage = {
		default = 150,--10 DPS
	},
	customparams = {
		heatgenerated		= "75", --6/sec
		cegflare			= "MISSILE_MUZZLEFLASH",
		weaponclass			= "missile",
		ammotype			= "lrm",
		minrange			= "500",
    },
}

return lowerkeys({ LRM15 = weaponDef })