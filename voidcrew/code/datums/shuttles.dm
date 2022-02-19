/datum/map_template/shuttle
	///How many shuttle parts are required to purchase this ship
	var/parts_needed
	///How good this ship is at
	var/ship_level = SHIP_WEAK

/datum/map_template/shuttle/ruin/solgov_exploration_pod
	file_name = "ruin_solgov_exploration_pod"
	name = "SolGov Exploration Pod"

/datum/map_template/shuttle/proc/get_password_cost()
	switch(parts_needed)
		if (1)
			return 1
		if (2 to 3)
			return 2
		else
			return 3
