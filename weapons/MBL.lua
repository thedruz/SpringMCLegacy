weaponDef = {
	name                    = "Medium Beam Laser",
	weaponType              = "BeamLaser",
	beamLaser				= true,
	beamLaser				= 1,
--	beamWeapon				= true,
--	largeBeamLaser			= true,
	renderType				= 0,
	lineOfSight				= true,
	explosionGenerator    	= "custom:AP_SMALL",
	soundHit              	= [[GEN_Beam_Explode1]],
	soundStart           	= [[MBL_Fire]],
	burnblow				= true, 	--Bullets explode at range limit.
	collideFriendly			= true,
	noSelfDamage            = true,
	turret                  = true,
	range                   = 900,
	accuracy                = 100,
	tollerance				= 100,
	areaOfEffect            = 5,
	weaponVelocity          = 2000,
	weaponTimer				= 0.8,
	reloadtime              = 3,
	size 					= 0.05,
	laserFlareSize			= 0.1,
	thickness				= 1.0,
	coreThickness			= 0.3,
	beamDecay          		= 1,
	beamTime           		= 0.75,
	beamTTL           		= 0.75,
	minIntensity			= 1,
	rgbcolor				= "0.4 1.0 0.4",
	intensity				= 0.75,
	damage = {
		default = 150, --50 DPS
	},
	customparams = {
		heatgenerated		= "9",--3/sec
    },
}

return lowerkeys({ MBL = weaponDef })