local AC_Class = Weapon:New{
	weaponType              = "Cannon",
	burnblow				= false, 	--Bullets explode at range limit.
	collideFriendly			= true,
	noSelfDamage            = true,
	turret                  = true,
	sizeDecay				= 0,
	separation				= 2, 		--Distance between each plasma particle.
	stages					= 40, 		--Number of particles used in one plasma shot.
--	AlphaDecay				= 0.05, 		--How much a plasma particle is more transparent than the previous particle. 
	rgbcolor				= "1 0.8 0",
	intensity				= 0.1,
	customparams = {
		weaponclass			= "projectile",
    },	
}

local LBX_Class = Weapon:New{
	explosionGenerator    	= "custom:MG_Hit",
	areaOfEffect            = 1,
	collisionSize			= 5,
	weaponVelocity          = 2500,
	size					= 0.8,
	stages					= 5, 		--Number of particles used in one plasma shot.
	intensity				= 0.5,
	dynDamageExp			= 1.0,	
}

-- AC2 & Variants
local AC2 = AC_Class:New{
	name                    = "AC/2",
	collisionSize			= 10,
	explosionGenerator    	= "custom:HE_XSMALL",
	soundHit              	= "AC2_Hit",
	soundStart            	= "AC2_Fire",
	range                   = 2400,
	accuracy                = 25,
	impactOnly				= true,
	weaponVelocity          = 4000,
	reloadtime              = 0.2,
	size					= 0.75,
	damage = {
		default = 16, --40 DPS
	},
	customparams = {
		heatgenerated		= 0.1,--0.5/s
		cegflare			= "AC2_MUZZLEFLASH",
		ammotype			= "ac2",
    },
}

local RAC2 = AC2:New{
	name                    = "Rotary AC/2",
	range                   = 1800,
	sprayangle				= 25,
	weaponVelocity          = 2000,
	burst					= 10,
	burstrate				= 0.04,
	reloadtime              = 0.4,
	customparams = {
		heatgenerated		= 4,--0.5/s
		spinspeed			= 600,
		flareonshot 		= true,
    },
}

local UAC2 = AC2:New{
	name                    = "Ultra AC/2",
	reloadtime              = 0.1,
}

-- AC5 & Variants
local AC5 = AC_Class:New{
	name                    = "AC/5",
	explosionGenerator    	= "custom:HE_SMALL",
	soundHit              	= "AC5_Hit",
	soundStart            	= "AC5_Fire",
	range                   = 1800,
	accuracy                = 1,
	impactOnly				= true,
	weaponVelocity          = 3000,
	reloadtime              = 1,
	size					= 1,
	damage = {
		default = 100, --100 DPS
	},
	customparams = {
		heatgenerated		= 0.5,--1/sec
		cegflare			= "AC5_MUZZLEFLASH",
		ammotype			= "ac5",
    },
}

local AC5_AA = AC5:New{
	name                    = "AC/5 Flak",
	burnblow				= true, 	--Bullets explode at range limit.
	accuracy                = 25,
	areaOfEffect            = 50,
	collisionSize			= 15,
	edgeEffectiveness		= 1,
	reloadtime              = 0.5,
	damage = {
		default = 50, --50 DPS
		vtol	= 100, --200% of default
	},
}

local RAC5 = AC5:New{
	name                    = "Rotary AC/5",
	range                   = 1500,
	accuracy                = 25,
	sprayangle				= 250,
	weaponVelocity          = 1750,
	burst					= 8,
	burstrate				= 0.2,
	reloadtime              = 1.5,
	customparams = {
		heatgenerated		= 4,--1/sec
		--cegflare			= "MISSILE_MUZZLEFLASH",
		spinspeed			= 600,
		flareonshot 		= true,
    },	
}

local UAC5 = AC5:New{
	name                    = "Ultra AC/5",
	range                   = 2000,
	accuracy                = 50,
	reloadtime              = 0.5,
	customparams = {
		heatgenerated		= 0.56,--1.5/sec
    },
}

local LBX5 = AC5:New(LBX_Class):New{
	name                    = "LBX/5",
	soundStart            	= "LBX5_Fire",
	accuracy                = 100,
	reloadtime              = 1,
	sprayAngle				= 400,
	projectiles				= 5,
	dynDamageMin			= 30,
	damage = {
		default = 60, --150 DPS
	},
	customparams = {
		heatgenerated		= 1,--1/sec
    },
}

-- AC10 & Variants
local AC10 = AC_Class:New{
	name                    = "AC/10",
	explosionGenerator    	= "custom:HE_MEDIUM",
	soundHit              	= "AC10_Hit",
	soundStart            	= "AC10_Fire",
	range                   = 1500,
	accuracy                = 25,
	areaOfEffect            = 25,
	weaponVelocity          = 2000,
	reloadtime              = 1.5,
	size					= 1.5,
	stages					= 50, 		--Number of particles used in one plasma shot.
	damage = {
		default = 300, --200 DPS
	},
	customparams = {
		heatgenerated		= 2,--3/sec
		cegflare			= "AC10_MUZZLEFLASH",
		ammotype			= "ac10",
    },
}

local UAC10 = AC10:New{
	name                    = "Ultra AC/10",
	reloadtime              = 0.75,
}

local LBX10 = AC10:New(LBX_Class):New{
	name                    = "LBX/10",
	soundStart            	= "LBX10_Fire",
	accuracy                = 250,
	reloadtime              = 3,
	sprayAngle				= 600,
	projectiles				= 10,
	dynDamageMin			= 45,
	damage = {
		default = 90, --300 DPS
	},
	customparams = {
		heatgenerated		= 3,--2/sec
    },
}

-- AC20 & Variants
local AC20 = AC_Class:New{
	name                    = "AC/20",
	explosionGenerator    	= "custom:HE_LARGE",
	soundHit             	= "AC20_Hit",
	soundStart           	= "AC20_Fire",
	range                   = 900,
	accuracy                = 50,
	areaOfEffect            = 50,
	weaponVelocity          = 2000,
	reloadtime              = 2.5,
	size					= 2,
	stages					= 50, 		--Number of particles used in one plasma shot.
	intensity				= 0.2,
	damage = {
		default = 1000, --400 DPS
	},
	customparams = {
		heatgenerated		= 17.5,--7/sec
		cegflare			= "AC20_MUZZLEFLASH",
		ammotype			= "ac20",
		shockwave			= true,
    },
}

local UAC20 = AC20:New{
	name                    = "Ultra AC/20",
	range                   = 1050,
	reloadtime              = 1.25,
}

local LBX20 = AC20:New(LBX_Class):New{
	name                    = "LBX/20",
	soundStart            	= "LBX20_Fire",
	accuracy                = 250,
	reloadtime              = 5,
	sprayAngle				= 800,
	projectiles				= 20,
	dynDamageMin			= 75,
	damage = {
		default = 150, --600 DPS
	},
	customparams = {
		heatgenerated		= 30,--6/sec
		shockwave = false,
    },
}

-- Return the weapons
return lowerkeys({ 
	-- AC2 & Variants
	AC2 = AC2,
	RAC2 = RAC2,
	UAC2 = UAC2,
	-- AC5 & Variants
	AC5 = AC5,
	AC5_AA = AC5_AA,
	RAC5 = RAC5,
	UAC5 = UAC5,
	LBX5 = LBX5,
	-- AC10 & Variants
	AC10 = AC10,
	UAC10 = UAC10,
	LBX10 = LBX10,
	-- AC20 & Variants
	AC20 = AC20,
	UAC20 = UAC20,
	LBX20 = LBX20,
})