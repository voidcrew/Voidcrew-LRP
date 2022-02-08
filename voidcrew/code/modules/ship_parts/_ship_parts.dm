/client/proc/get_ship_parts(ship_faction, parts_required, ship_level)
	for(var/datum/ship/ships as anything in prefs.ships_owned)
		if(initial(ships.faction) != ship_faction)
			continue
		if(initial(ships.level) != ship_level)
			continue
		if(prefs.ships_owned[ships] >= parts_required)
			return TRUE
		return FALSE

/client/proc/remove_ship_cost(ship_faction, ship_cost, ship_level)
	for(var/datum/ship/ships as anything in prefs.ships_owned)
		if(initial(ships.faction) != ship_faction)
			continue
		if(initial(ships.level) != ship_level)
			continue
		prefs.ships_owned[ships] -= ship_cost
		return

/client/proc/give_random_ship()
	var/datum/ship/selected_ship = pick(subtypesof(/datum/ship))
	prefs.ships_owned[selected_ship]++
	to_chat(src, "You have been granted [selected_ship][selected_ship.faction == FACTION_NEUTRAL ? " [selected_ship.level]" : ""] type ship parts!")
