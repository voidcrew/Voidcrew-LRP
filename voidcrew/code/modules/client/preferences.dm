/datum/preferences
	///Currently owned ships
	var/list/ships_owned = list(
		/datum/ship/neutral = 0,
		/datum/ship/neutral/medium = 0,
		/datum/ship/neutral/high = 0,
		/datum/ship/nanotrasen = 0,
		/datum/ship/syndicate = 0,
	)

/datum/preferences/New()
	. = ..()
	features |= list(
		"ipc_screen" = "Blue",
		"ipc_antenna" = "None",
		"ipc_chassis" = "Morpheus Cyberkinetics(Greyscale)",
		"kepori_feathers" = "Plain",
		"kepori_body_feathers" = "Plain",
		"squid_face" = "Squidward",
	)
