--- Valid entries used by engine: IncomingChat, MultiSelect, MapPoint
--- other than that, you can give it any name and access it like before with filenames
local Sounds = {
	SoundItems = {
		IncomingChat = {
			--- always play on the front speaker(s)
			file = "sounds/beep4.wav",
			in3d = "false",
		},
		MultiSelect = {
			--- always play on the front speaker(s)
			file = "sounds/button9.wav",
			in3d = "false",
		},
		MapPoint = {
			--- respect where the point was set, but don't attuenuate in distace
			--- also, when moving the camera, don't pitch it
			file = "sounds/beep6.wav",
			rolloff = 0,
			dopplerscale = 0,
		},
		ExampleSound = {
			--- some things you can do with this file

			--- can be either ogg or wav
			file = "somedir/subdir/soundfile.ogg",

			--- loudness, > 1 is louder, < 1  is more quiet, you will most likely not set it to 0
			gain = 1,

			--- > 1 -> high pitched, < 1 lowered
			pitch = 1,

			--- If > 0.0 then this adds a random amount to gain each time the sound is played.
			--- Clamped between 0.0 and 1.0. The result is in the range [(gain * (1 + gainMod)), (gain * (1 - gainMod))].
			gainmod = 0.0,

			--- If > 0.0 then this adds a random amount to pitch each time the sound is played.
			--- Clamped between 0.0 and 1.0. The result is in the range [(pitch * (1 + pitchMod)), (pitch * (1 - pitchMod))].
			pitchmod = 0.0,

			--- how unit / camera speed affects the sound, to exagerate it, use values > 1
			--- dopplerscale = 0 completely disables the effect
			dopplerscale = 1,

			--- when lots of sounds are played, sounds with lwoer priority are more likely to get cut off
			--- priority > 0 will never be cut of (priorities can be negative)
			priority = 0,

			--- this sound will not be played more than 16 times at a time
			maxconcurrent = 16,

			--- cutoff distance
			maxdist = 20000,

			--- how fast it becomes more quiet in the distance (0 means aleays the same loudness regardless of dist)
			rolloff = 1,

			--- non-3d sounds do always came out of the front-speakers (or the center one)
			--- 3d sounds are, well, in 3d
			in3d = true,

			--- you can loop it for X miliseconds
			looptime = 0,
		},
		FailedCommand = {
			file = "sounds/beep3.wav",
		},

		default = {
			--- new since 89.0
			--- you can overwrite the fallback profile here (used when no corresponding SoundItem is defined for a sound)
			gainmod = 0.35,
			pitchmod = 0.1,
		},
		
		-- BTL Unit Animation Sounds
		stomp = {
			file = "sounds/unit/stomp.wav",
			maxconcurrent = 12,
			gainmod = 0.35,
			pitchmod = 0.1,
			priority = -0.1,
			maxdist = 4000,
			rolloff = 10.0,
		},
		NavBeacon_Land = {
			file = "sounds/beacon/land.wav",
			maxconcurrent = 12,
			gainmod = 0.35,
			pitchmod = 0.1,
			priority = -0.1,
			maxdist = 5000,
			rolloff = 10.0,
		},
		NavBeacon_Beep = {
			file = "sounds/beacon/beep.wav",
			maxconcurrent = 12,
			gainmod = 0,
			pitchmod = 0,
			priority = -0.1,
			maxdist = 3000,
			rolloff = 10.0,
		},
		NavBeacon_Descend = {
			file = "sounds/beacon/descend.wav",
			maxconcurrent = 2,
			gainmod = 0.35,
			pitchmod = 0.1,
			priority = -0.1,
			maxdist = 5000,
			rolloff = 10.0,
			--looptime = 10000, -- 10s, 5s x2
		},
		NavBeacon_Pop = {
			file = "sounds/beacon/pop.wav",
			maxconcurrent = 12,
			gainmod = 0.35,
			pitchmod = 0.1,
			priority = -0.1,
			maxdist = 5000,
			rolloff = 10.0,
		},
		
		
		----BITCHING BETTY----
		
		-- Beacons
		BB_NavBeacon_Captured = {
			file = "sounds/betty/Beacon_Captured.wav",
			in3d = false,
		},
		
		BB_NavBeacon_Lost = {
			file = "sounds/betty/Beacon_Lost.wav",
			in3d = false,
		},
		
		BB_NavBeacon_UnderAttack = {
			file = "sounds/betty/Beacon_UnderAttack.wav", --also Beacon_UnderAttack_2.wav
			in3d = false,
		},
		
		BB_NavBeacon_Secured = {
			file = "sounds/betty/Beacon_Secured.wav",
			in3d = false,
		},
		
		-- Dropships
		BB_Dropship_Inbound = {
			file = "sounds/betty/Dropship_Inbound.wav",
			in3d = false,
		},
		
		BB_Dropship_UnderAttack= {
			file = "sounds/betty/Dropship_UnderAttack.wav",
			in3d = false,
		},
		
		-- Towers
		BB_BAP_Deployed = {
			file = "sounds/betty/BAP_Deployed.wav",
			in3d = false,
		},
		
		BB_Turret_Deployed = {
			file = "sounds/betty/Turret_Deployed.wav",
			in3d = false,
		},
		
		-- Upgrades
		BB_Upgrade_Uplink_Deployed = {
			file = "sounds/betty/Uplink_Deployed.wav",
			in3d = false,
		},
		
		BB_Upgrade_Uplink_UnderAttack = {
			file = "sounds/betty/Uplink_UnderAttack.wav",
			in3d = false,
		},
		
		BB_Upgrade_Uplink_Destroyed = {
			file = "sounds/betty/Uplink_Destroyed.wav",
			in3d = false,
		},
		
		BB_Upgrade_Mechbay_Deployed = {
			file = "sounds/betty/Mechbay_Deployed.wav",
			in3d = false,
		},
		
		BB_Upgrade_Mechbay_UnderAttack = {
			file = "sounds/betty/Mechbay_UnderAttack.wav",
			in3d = false,
		},
		
		BB_Upgrade_Mechbay_Destroyed = {
			file = "sounds/betty/Mechbay_Destroyed.wav",
			in3d = false,
		},
		
		BB_Upgrade_Garrison_Deployed = {
			file = "sounds/betty/Garrison_Deployed.wav",
			in3d = false,
		},
		
		BB_Upgrade_Garrison_UnderAttack = {
			file = "sounds/betty/Garrison_UnderAttack.wav",
			in3d = false,
		},
		
		BB_Upgrade_Garrison_Destroyed = {
			file = "sounds/betty/Garrison_Destroyed.wav",
			in3d = false,
		},
		
		BB_Wall_Deployed = {
			file = "sounds/betty/Wall_Deployed.wav",
			in3d = false,
		},
		
		BB_Battlemech_Destroyed = {
			file = "sounds/betty/Battlemech_Destroyed.wav",
			in3d = false,
		},
		
		BB_Vehicle_Destroyed = {
			file = "sounds/betty/Vehicle_Destroyed.wav",
			in3d = false,
		},
		
		BB_VTOL_Destroyed = {
			file = "sounds/betty/Vehicle_Destroyed.wav",
			in3d = false,
		},
		
		BB_Aerofighter_Destroyed = {
			file = "sounds/betty/Vehicle_Destroyed.wav",
			in3d = false,
		},
	},
}

return Sounds
