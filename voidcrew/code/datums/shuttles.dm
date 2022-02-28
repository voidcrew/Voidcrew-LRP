/datum/map_template/shuttle // VOID TODO: make this into a subtype so we don't interfere with tg's shuttles
	///The prefix signifying the ship's faction
	var/faction_prefix = "NEU"
	///Amount of ships able to be active at once
	var/limit
	///Cost (in metacoins) of the ship
	var/cost
	///Short name of the ship
	var/short_name
	///List of job slots
	var/list/job_slots
	///List of generic names to apply to the ship
	var/list/name_categories = list("GENERAL")
	///The antag datum to give a player on join
	var/antag_datum
	///Should this ship be able to be password protected
	var/disable_passwords

/**
 * ##get_password_cost
 *
 * Returns the cost of the password, based on the total cost of the ship
 */
/datum/map_template/shuttle/proc/get_password_cost()
	switch (cost)
		if (1 to 450)
			return cost * 1
		if (451 to 750)
			return cost * 0.6
		else
			return cost * 0.4

/datum/map_template/shuttle/ruin/solgov_exploration_pod
	file_name = "ruin_solgov_exploration_pod"
	name = "SolGov Exploration Pod"
