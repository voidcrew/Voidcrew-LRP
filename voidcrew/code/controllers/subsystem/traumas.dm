/datum/controller/subsystem/traumas/Initialize()
	. = ..()
	phobia_species["robots"] = typecacheof(list(/datum/species/android, /datum/species/ipc))
	phobia_species |= list("birds" = typecacheof(list(/datum/species/kepori)))
