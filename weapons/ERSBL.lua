weaponDef = {
	name                    = "ERSBL",
	weaponType              = "BeamLaser",
	beamLaser				= true,
	beamLaser				= 1,
--	beamWeapon				= true,
--	largeBeamLaser			= true,
	renderType				= 0,
	lineOfSight				= true,
	explosionGenerator    	= "custom:AP_SMALL",
	soundHit              	= [[GEN_Beam_Explode1]],
	soundStart           	= [[SBL_Fire]],
	burnblow				= true, 	--Bullets explode at range limit.
	collideFriendly			= true,
	noSelfDamage            = true,
	turret                  = true,
	range                   = 500,
	accuracy                = 100,
	tollerance				= 100,
	areaOfEffect            = 5,
	weaponVelocity          = 2000,
	weaponTimer				= 0.8,
	reloadtime              = 2.5,
	size 					= 0.05,
	laserFlareSize			= 0.1,
	thickness				= 0.75,
	coreThickness			= 0.1,
	beamDecay          		= 1,
	beamTime           		= 1,
	beamTTL           		= 1,
	minIntensity			= 1,
	rgbcolor				= "1.0 0.0 1.0",
	intensity				= 0.75,
	damage = {
		default = 75, --30 DPS
	},
	
	
	
}

return lowerkeys({ ERSBL = weaponDef })