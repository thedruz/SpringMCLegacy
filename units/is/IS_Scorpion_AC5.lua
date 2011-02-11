local IS_Scorpion_AC5 = {
	name              	= "Scorpion (AC/5)",
	description         = "Light Strike Tank",
	objectName        	= "IS_Scorpion_AC5.s3o",
	script				= "IS_Scorpion_AC5.lua",
	category 			= "tank ground notbeacon",
	sightDistance       = 1000,
	radarDistance      	= 1500,
		activateWhenBuilt   = true,
		onoffable           = true,
	maxDamage           = 1000,
	mass                = 2500,
	footprintX			= 2,
	footprintZ 			= 2,
	collisionVolumeType = "box",
	collisionVolumeScales = "20 12 30",
	collisionVolumeOffsets = "0 2 0",
	leaveTracks			= 1,
	trackOffset			= 10,--no idea what this does
	trackStrength		= 2.5,--how visible the tracks are
	trackStretch		= 1,-- how much the tracks stretch, the higher the number the more "compact" they become
	trackType			= "Thick",--graphics file to use for the track decal, from \bitmaps\tracks\ folder
	trackWidth			= 20,--width to render the decal
	collisionVolumeTest = 1,
	buildCostEnergy     = 0,
	buildCostMetal      = 300,
	buildTime           = 0,
	canMove				= true,
		movementClass   = "TANK",
		maxVelocity		= 2.16, --65kph/30
		maxReverseVelocity= 1.6,
		acceleration    = 1.0,
		brakeRate       = 0.1,
		turnRate 		= 500,
	
	canAttack 			= true,
		--Makes unit use weapon from /weapons folder
		weapons 		= {	
			[1] = {
				name	= "AC5",
				OnlyTargetCategory = "notbeacon",
			},
			[2] = {
				name	= "MG",
				OnlyTargetCategory = "notbeacon",
				WeaponSlaveTo = 1,
			},
			[3] = {
				name	= "MG",
				OnlyTargetCategory = "notbeacon",
				WeaponSlaveTo = 1,
			},
		},
		
	--Gets CEG effects from /gamedata/explosions folder

	sfxtypes = {
		explosiongenerators = {
		"custom:SMALL_MUZZLEFLASH",
		"custom:MG_MUZZLEFLASH",
		},
	},
    customparams = {
		hasturnbutton	= "1",
		helptext		= "Armament: 1 x Autocannon/5, 2 x Machinegun - Armor: 2 tons",
    },
}

return lowerkeys({ ["IS_Scorpion_AC5"] = IS_Scorpion_AC5 })