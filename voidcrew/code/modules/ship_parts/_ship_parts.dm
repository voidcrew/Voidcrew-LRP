/client/proc/get_ship_parts(ship_faction, parts_required, ship_level)
	for(var/datum/ship_parts/ships as anything in prefs.ships_owned)
		if(initial(ships.faction) != ship_faction)
			continue
		if(initial(ships.level) != ship_level)
			continue
		if(prefs.ships_owned[ships] >= parts_required)
			return TRUE
		return FALSE

/client/proc/remove_ship_cost(ship_faction, ship_cost, ship_level)
	for(var/datum/ship_parts/ships as anything in prefs.ships_owned)
		if(initial(ships.faction) != ship_faction)
			continue
		if(initial(ships.level) != ship_level)
			continue
		prefs.ships_owned[ships] -= ship_cost
		prefs.save_ships()

/client/proc/give_random_ship_part()
	var/datum/ship_parts/selected_ship = pick(subtypesof(/datum/ship_parts))
	prefs.ships_owned[selected_ship]++
	to_chat(src, "You have been granted [selected_ship][selected_ship.faction == FACTION_NEUTRAL ? " [selected_ship.level]" : ""] type ship parts!")
	prefs.save_ships()

/client/proc/list_ship_parts()
	to_chat(usr, "<span class='boldwarning'>Currently owned ship parts:</span>")
	for(var/datum/ship_parts/ships as anything in prefs.ships_owned)
		if(initial(prefs.ships_owned[ships]) < 1)
			continue
		to_chat(usr, "<span class='boldwarning'>[prefs.ships_owned[ships]] [initial(ships.name)]</span>")

/client/proc/get_ships()
	var/list/owned_ships = list()
	for(var/datum/ship_parts/ships as anything in prefs.ships_owned)
		if(initial(prefs.ships_owned[ships]) < 1)
			continue
		owned_ships["[initial(ships.name)] - [initial(prefs.ships_owned[ships])] owned"] = ships

	if(!length(owned_ships))
		to_chat(src, "You do not have any ship parts.")
		return FALSE
	return owned_ships
