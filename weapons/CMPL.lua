weaponDef = {
	name                    = "Clan Medium Pulse Laser",
	weaponType              = "BeamLaser",
	beamLaser				= true,
	beamBurst				= true,
--	largeBeamLaser			= true,
	renderType				= 0,
	lineOfSight				= true,
	explosionGenerator    	= "custom:Laser_Medium",
--	soundHit              	= [[GEN_Pulse_Explode1]],
	soundStart           	= [[MPL_Fire]],
	burnblow				= true, 	--Bullets explode at range limit.
	collideFriendly			= true,
	noSelfDamage            = true,
	turret                  = true,
	range                   = 800,
	accuracy                = 25,
	tollerance				= 100,
	areaOfEffect            = 5,
	weaponVelocity          = 2000,
	weaponTimer				= 0.8,
	reloadtime              = 3,
	size 					= 0.1,
	laserFlareSize			= 0.1,
	thickness				= 1,
	coreThickness			= 0.1,
	beamDecay          		= 1,
	beamTime           		= 0.01,
	beamTTL           		= 1,
	burst					= 5,
	burstrate				= 0.1,
	minIntensity			= 1,
	rgbcolor				= "0.4 0.8 0.4",
	intensity				= 0.6,
	damage = {
		default = 8.4, --70 DPS, 42 damage per reload
	},
	customparams = {
		heatgenerated		= "2.4",--4/sec
		cegflare			= "LASER_MUZZLEFLASH",
    },
}

return lowerkeys({ CMPL = weaponDef })