local Turret_BAP = Tower:New{
	name              	= "Sensor Emplacement",
	description         = "Beagle Active Probe",

	customparams = {
		bap			= true,
    },
}

return lowerkeys({
	["Turret_BAP"] = Turret_BAP,
})