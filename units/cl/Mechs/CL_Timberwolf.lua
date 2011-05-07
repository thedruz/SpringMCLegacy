local CL_Timberwolf = {
	name              	= "Timber Wolf (Mad Cat)",
	description         = "Heavy Strike Mech",
	objectName        	= "CL_Timberwolf.s3o",
	iconType			= "heavymech",
	script				= "Mech.lua",
	corpse				= "CL_Timberwolf_X",
	explodeAs          	= "mechexplode",
	category 			= "mech ground notbeacon",
	sightDistance       = 800,
	radarDistance      	= 1500,
		activateWhenBuilt   = true,
		onoffable           = true,
	maxDamage           = 23000,
	mass                = 7500,
	footprintX			= 3,
	footprintZ 			= 3,
	--collisionVolumeType = "box",
	--collisionVolumeScales = "40 50 40",
	--collisionVolumeOffsets = "0 0 0",
	collisionVolumeTest = 1,
	usePieceCollisionVolumes = true,
--	leaveTracks			= 1,
--	trackOffset			= 10,--no idea what this does
--	trackStrength		= 2.5,--how visible the tracks are
--	trackStretch		= 1,-- how much the tracks stretch, the higher the number the more "compact" they become
--	trackType			= "Thick",--graphics file to use for the track decal, from \bitmaps\tracks\ folder
--	trackWidth			= 20,--width to render the decal
	buildCostEnergy     = 75,
	buildCostMetal      = 37200,
	buildTime           = 0,
	upright				= true,
	canMove				= true,
		movementClass   = "LARGEMECH",
		maxVelocity		= 4.3, --86kph/20
		maxReverseVelocity= 2.15,
		acceleration    = 1,
		brakeRate       = 0.2,
		turnRate 		= 700,
		smoothAnim		= 1,
	
	canAttack 			= true,
		--Makes unit use weapon from /weapons folder
		weapons 		= {	
			[1] = {
				name	= "CERLBL",
				mainDir = "0 0 1",
				maxAngleDif = 270,
				OnlyTargetCategory = "notbeacon",
			},
			[2] = {
				name	= "CERLBL",
				--weaponSlaveTo2 = 1,
				mainDir = "0 0 1",
				maxAngleDif = 270,
				OnlyTargetCategory = "notbeacon",
				WeaponSlaveTo = 1,
			},
			[3] = {
				name	= "CERMBL",
				mainDir = "0 0 1",
				maxAngleDif = 270,
				OnlyTargetCategory = "notbeacon",
				WeaponSlaveTo = 1,
			},
			[4] = {
				name	= "CERMBL",
				mainDir = "0 0 1",
				maxAngleDif = 270,
				OnlyTargetCategory = "notbeacon",
				WeaponSlaveTo = 1,
			},
			[5] = {
				name	= "CSPL",
				mainDir = "0 0 1",
				maxAngleDif = 270,
				OnlyTargetCategory = "notbeacon",
				WeaponSlaveTo = 1,
			},
			[6] = {
				name	= "CSPL",
				mainDir = "0 0 1",
				maxAngleDif = 270,
				OnlyTargetCategory = "notbeacon",
				WeaponSlaveTo = 1,
			},
			[7] = {
				name	= "MG",
				mainDir = "0 0 1",
				maxAngleDif = 270,
				OnlyTargetCategory = "notbeacon",
				WeaponSlaveTo = 1,
			},
			[8] = {
				name	= "MG",
				mainDir = "0 0 1",
				maxAngleDif = 270,
				OnlyTargetCategory = "notbeacon",
				WeaponSlaveTo = 1,
			},
			[9] = {
				name	= "ATM9",
				mainDir = "0 0 1",
				maxAngleDif = 270,
				OnlyTargetCategory = "notbeacon",
				WeaponSlaveTo = 1,
			},
			[10] = {
				name	= "ATM9",
				mainDir = "0 0 1",
				maxAngleDif = 270,
				OnlyTargetCategory = "notbeacon",
				WeaponSlaveTo = 1,
			},
		},

    customparams = {
		hasturnbutton	= "1",
		helptext		= "Armament: 2 x ER Large Beam Laser, 2 x ER Medium Beam Laser, 2 x Small Pulse Laser, 2 x MG, 2 x ATM-12 - Armor: 12 tons Ferro-Fibrous",
		heatlimit		= "34",
		torsoturnspeed	= "130",
		unittype		= "mech",
    },
}

return lowerkeys({ ["CL_Timberwolf"] = CL_Timberwolf })