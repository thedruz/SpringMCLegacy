weaponDef = {
	name                    = "Clan Extended Range Particle Projector Cannon",
	weaponType              = "Cannon",
	explosionGenerator    	= "custom:PPC",
--	cegTag					= "RailTrail",
	soundHit              	= [[PPC_Hit]],
	soundStart            	= [[PPC_Fire]],
	burnblow				= false, 	--Bullets explode at range limit.
	collideFriendly			= true,
	noSelfDamage            = true,
	turret                  = true,
--	ballistic				= 1,
	lineOfSight				= 1,
	range                   = 2300,
	accuracy                = 100,
	targetMoveError			= 0.05,
	movingAccuracy			= 500,
	areaOfEffect            = 10,
	weaponVelocity          = 2000,
	reloadtime              = 5,
	renderType				= 1,
	size					= 3,
	sizeDecay				= 0,
	separation				= 1.5, 		--Distance between each plasma particle.
	stages					= 100, 		--Number of particles used in one plasma shot.
--	AlphaDecay				= 0.05, 		--How much a plasma particle is more transparent than the previous particle. 
	rgbcolor				= "0.5 0.5 1.0",
	intensity				= 0.5,
	damage = {
		default = 750, --150 DPS
		beacons = 0,
		vehicle = 750,
	},
	customparams = {
		heatgenerated		= "50",--10/sec
		cegflare			= "PPC_MUZZLEFLASH",
    },
}

return lowerkeys({ ERPPC = weaponDef })