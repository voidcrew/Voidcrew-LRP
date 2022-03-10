/datum/gas_mixture/immutable/cloner
	initial_temperature = T20C

/datum/gas_mixture/immutable/cloner/New()
	. = ..()
	add_gas(/datum/gas/nitrogen)
	gases[/datum/gas/nitrogen][MOLES] = MOLES_O2STANDARD + MOLES_N2STANDARD
