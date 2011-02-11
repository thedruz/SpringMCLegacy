weaponDef = {
	name                    = "Arrow IV",
	weaponType              = "MissileLauncher",
	renderType				= 1,
	explosionGenerator    	= "custom:HE_LARGE",
--	cegTag					= "BazookaTrail",
	smokeTrail				= true,
	smokeDelay				= "0.05",
	soundHit              	= [[GEN_Explode5]],
	soundStart            	= [[Arrow_Fire]],
--	soundTrigger			= 0,
	burnblow				= false, 	--Bullets explode at range limit.
	collideFriendly			= true,
	noSelfDamage            = true,
	turret                  = true,
	range                   = 4000,
	accuracy                = 1000,
	wobble					= 200,
	guidance				= true,
	selfprop				= true,
	ballistic				= false,
	trajectoryHeight		= 1,
	tracks					= true,
	turnRate				= 500,
	weaponTimer				= 50,
	flightTime				= 50,
	areaOfEffect            = 175,
	startVelocity			= 500,
	weaponVelocity          = 500,
	reloadtime              = 15,
	model					= "LargeMissile.s3o",
	damage = {
		default = 3000,--200 DPS
		dropships = 1,--haha fuck you flozi
		beacons = 0,
	},
	customparams = {
		heatgenerated		= "200",--10/sec
    },
}

return lowerkeys({ ArrowIV = weaponDef })