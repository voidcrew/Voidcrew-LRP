/datum/map_template/shuttle
	///How many shuttle parts are required to purchase this ship
	var/parts_needed
	///How good this ship is at
	var/ship_level

/datum/map_template/shuttle/New(path, rename, cache)
	. = ..()
	if(prefix != FACTION_NEUTRAL)
		ship_level = SHIP_WEAK
		return
	switch(parts_needed)
		if(1)
			ship_level = SHIP_WEAK
		if(2)
			ship_level = SHIP_MEDIUM
		if(3, INFINITY)
			ship_level = SHIP_STRONG

/datum/map_template/shuttle/ruin/solgov_exploration_pod
	file_name = "ruin_solgov_exploration_pod"
	name = "SolGov Exploration Pod"
