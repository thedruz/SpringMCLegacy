weaponDef = {
	name                    = "Anti-Missile System (AMS)",
	isShield				= true,
	shieldInterceptType		= 32,
	exteriorShield			= true,
	shieldEnergyUse			= 0,
	shieldPower				= 500,
	shieldPowerRegen		= 250,
	shieldPowerRegenEnergy	= 0,
	shieldRadius			= 250,
	shieldStartingPower		= 500,
	smartShield				= true,
	visibleShield			= false,
		shieldAlpha				= 1.0,
		shieldGoodColor			= "0.0 1.0 0.0",
		shieldBadColor			= "1.0 0.0 0.0",
	damage = {
		default = 10,--1 DPS
	},

}

return lowerkeys({ AMS = weaponDef })