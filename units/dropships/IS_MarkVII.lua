local IS_MarkVII = {
	name              	= "Mark VII Landing Craft",
	description         = "Cargo Landing Craft",
	objectName        	= "IS_MarkVIIb.s3o",
	iconType			= "markvii",
	script				= "Dropship.lua",
	category 			= "ground notbeacon",
	activateWhenBuilt   = true,
	maxDamage           = 10000,
	mass                = 13000,
	footprintX			= 20,
	footprintZ 			= 20,
	--collisionVolumeType = "ellipsoid",
	buildCostEnergy     = 0,
	buildCostMetal      = 0,
	buildTime           = 0,
	canMove				= true,
	maxVelocity			= 0,
	idleAutoHeal		= 0,
	maxSlope			= 50,
	moveState			= 0,
	levelGround			= false,
	movementClass		= "LARGEMECH", -- herp
	usePieceCollisionVolumes = true,
	power				= 1, -- don't target me!
	
	-- Transport tags
	transportSize		= 8,
	transportCapacity	= 64, -- 1x transportSize
	transportMass		= 1000000,
	holdSteady 			= true,

	--Makes unit use weapon from /weapons folder
	weapons	= {	
		[1] = {
			name	= "ERMBL",
			maxAngleDif = 100,
		},
		[2] = {
			name	= "ERMBL",
			maxAngleDif = 100,
		},
		[3] = {
			name	= "ERMBL",
			maxAngleDif = 100,
			--mainDir = [[-1 0 0]],
		},
		[4] = {
			name	= "ERMBL",
			maxAngleDif = 100,
			--mainDir = [[-1 0 0]],
		},
		[5] = {
			name	= "ERMBL",
			maxAngleDif = 100,
			--mainDir = [[1 0 0]],
		},
		[6] = {
			name	= "ERMBL",
			maxAngleDif = 100,
			--mainDir = [[1 0 0]],
		},
		[7] = {
			name	= "ERMBL",
			maxAngleDif = 100,
			mainDir = [[0 0 -1]],
		},
		[8] = {
			name	= "ERMBL",
			maxAngleDif = 100,
			mainDir = [[0 0 -1]],
		},
	},
	--Gets CEG effects from /gamedata/explosions folder
	sfxtypes = {
		explosiongenerators = {
			--"custom:heavy_jet_trail",
			"custom:dropship_main_engine_stage2",
		},
	},
	customparams = {
		helptext		= "A Dropship",
		dropship		= "vehicle",
		hoverheight		= 43 + 12,
		radialdist		= 2500,
		ignoreatbeacon	= true,
    },
	sounds = {
		underattack        = "Dropship_Alarm",
	},
}

return lowerkeys({["IS_MarkVII"] = IS_MarkVII})