local Turret_BAP = Tower:New{
	name              	= "Sensor Emplacement",
	description         = "Beagle Active Probe",
	buildCostMetal      = 4000,

	customparams = {
		bap			= true,
    },
}

return lowerkeys({
	["Turret_BAP"] = Turret_BAP,
})