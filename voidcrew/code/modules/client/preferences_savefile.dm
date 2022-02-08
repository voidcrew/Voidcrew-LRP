/datum/preferences/load_preferences()
	. = ..()
	if(!.)
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	READ_FILE(S["ships_owned"], ships_owned)
	be_special = SANITIZE_LIST(ships_owned)


/datum/preferences/save_preferences()
	. = ..()
	if(!.)
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	WRITE_FILE(S["ships_owned"], ships_owned)
