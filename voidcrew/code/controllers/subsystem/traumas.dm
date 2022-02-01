/datum/controller/subsystem/traumas/Initialize()
	. = ..()
	phobia_species["robots"] = typecacheof(list(/datum/species/android, /datum/species/ipc))
