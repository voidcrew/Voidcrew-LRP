/datum/preferences
	///Currently owned ships
	var/list/ships_owned = list(
		/datum/ship_parts/neutral = 0,
		/datum/ship_parts/neutral/medium = 0,
		/datum/ship_parts/neutral/high = 0,
		/datum/ship_parts/nanotrasen = 0,
		/datum/ship_parts/syndicate = 0,
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

/datum/preferences/proc/save_ships()
	if(!path)
		return FALSE
	if(!fexists(path))
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/"
	WRITE_FILE(S["ships_owned"], ships_owned)
