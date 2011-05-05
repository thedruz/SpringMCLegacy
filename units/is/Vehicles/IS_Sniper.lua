local IS_Sniper = {
	name              	= "Sniper",
	description         = "Mobile Artillery",
	objectName        	= "IS_Sniper.s3o",
	script				= "Vehicle.lua",
	corpse				= "IS_Sniper_X",
	explodeAs          	= "mechexplode",
	category 			= "tank ground notbeacon",
	sightDistance       = 800,
	radarDistance      	= 1500,
	activateWhenBuilt   = true,
	onoffable           = true,
	maxDamage           = 6400,
	mass                = 8000,
	footprintX			= 2,
	footprintZ 			= 2,
	collisionVolumeType = "box",
	collisionVolumeScales = "27 20 40",
	collisionVolumeOffsets = "0 3 0",
	collisionVolumeTest = 1,
	leaveTracks			= 1,
	trackOffset			= 10,--no idea what this does
	trackStrength		= 8,--how visible the tracks are
	trackStretch		= 1,-- how much the tracks stretch, the higher the number the more "compact" they become
	trackType			= "Thin",--graphics file to use for the track decal, from \bitmaps\tracks\ folder
	trackWidth			= 24,--width to render the decal
	buildCostEnergy     = 80,
	buildCostMetal      = 5000,
	buildTime           = 0,
	canMove				= true,
	movementClass   = "TANK",
	maxVelocity		= 1.8, --54kph/30
	maxReverseVelocity= 1.3,
	acceleration    = 0.6,
	brakeRate       = 0.1,
	turnRate 		= 300,
	
	canAttack 			= true,
		--Makes unit use weapon from /weapons folder
		weapons 		= {	
			[1] = {
				name	= "Sniper",
				mainDir = "0 0 1",
				maxAngleDif = 15,
				OnlyTargetCategory = "notbeacon",
			},
			[2] = {
				name	= "ERSBL",
				OnlyTargetCategory = "notbeacon",
			},
			[3] = {
				name	= "ERSBL",
				weaponslaveto = 2,
				OnlyTargetCategory = "notbeacon",
			},
		},
	customparams = {
		hasturnbutton	= "1",
		helptext		= "Armament: 1 x Sniper Artillery Gun, 2 x ER Small Beam Laser - Armor: 7 tons",
		heatlimit		= "15",
		unittype		= "vehicle",
		turretturnspeed = "50",
		turret2turnspeed = "200",
		elevationspeed = "50",
		turrets = "{[2] = 2, [3] = 2}",
		barrelrecoildist = "{[1] = 4}",
    },
}

return lowerkeys({ ["IS_Sniper"] = IS_Sniper })