/obj/structure/overmap/dynamic
	name = "weak energy signature"
	desc = "A very weak energy signal. It may not still be here if you leave it."
	icon_state = "strange_event"
	///The active turf reservation, if there is one
	var/datum/map_zone/mapzone
	///The preset ruin template to load, if/when it is loaded.
	var/datum/map_template/template
	///The docking port in the reserve
	var/obj/docking_port/stationary/reserve_dock
	///The docking port in the reserve
	var/obj/docking_port/stationary/reserve_dock_secondary
	///If the level should be preserved. Useful for if you want to build an autismfort or something.
	var/preserve_level = FALSE
	///What kind of planet the level is, if it's a planet at all.
	var/datum/overmap/planet
	///List of probabilities for each type of planet.
	var/static/list/probabilities
	///The planet that will be forced to load
	var/datum/overmap/planet/force_encounter

/obj/structure/overmap/dynamic/Initialize(mapload)
	. = ..()
	choose_level_type()

/obj/structure/overmap/dynamic/attack_ghost(mob/user)
	if(reserve_dock)
		user.forceMove(get_turf(reserve_dock))
		return TRUE
	else
		return

/obj/structure/overmap/dynamic/Destroy()
	. = ..()
	remove_mapzone()

/obj/structure/overmap/dynamic/proc/remove_mapzone()
	if(mapzone)
		mapzone.clear_reservation()
		QDEL_NULL(mapzone)

/obj/structure/overmap/dynamic/ship_act(mob/user, obj/structure/overmap/ship/simulated/acting)
	var/prev_state = acting.state
	acting.state = OVERMAP_SHIP_ACTING //This is so the controls are locked while loading the level to give both a sense of confirmation and to prevent people from moving the ship
	. = load_level(acting.shuttle)
	if(.)
		acting.state = prev_state
	else
		var/dock_to_use = null
		if(!reserve_dock.get_docked())
			dock_to_use = reserve_dock
		else if(!reserve_dock_secondary.get_docked())
			dock_to_use = reserve_dock_secondary

		if(!dock_to_use)
			acting.state = prev_state
			to_chat(user, "<span class='notice'>All potential docking locations occupied.</span>")
			return
		adjust_dock_to_shuttle(dock_to_use, acting.shuttle)
		to_chat(user, "<span class='notice'>[acting.dock(src, dock_to_use)]</span>") //If a value is returned from load_level(), say that, otherwise, commence docking

/**
  * Chooses a type of level for the dynamic level to use.
  */
/obj/structure/overmap/dynamic/proc/choose_level_type()
	var/datum/overmap/planet/chosen
	if (isnull(probabilities))
		probabilities = list()
		for (var/path in subtypesof(/datum/overmap/planet))
			var/datum/overmap/planet/temp_planet = new path
			probabilities |= list(temp_planet.type = min(length(temp_planet.ruin_list), temp_planet.spawn_rate))
			qdel(temp_planet)

	if(!isnull(force_encounter))
		chosen = force_encounter
	else
		chosen = pickweight(probabilities)

	chosen = new chosen

	name = chosen.name
	desc = chosen.desc
	planet = chosen.type
	icon_state = chosen.icon_state
	color = chosen.color

	desc += !preserve_level && "It may not still be here if you leave it."

	qdel(chosen)

/**
  * Load a level for a ship that's visiting the level.
  * * visiting shuttle - The docking port of the shuttle visiting the level.
  */
/obj/structure/overmap/dynamic/proc/load_level(obj/docking_port/mobile/visiting_shuttle)
	if(mapzone)
		return
	if(!COOLDOWN_FINISHED(SSovermap, encounter_cooldown))
		return "WARNING! Stellar interference is restricting flight in this area. Interference should pass in [COOLDOWN_TIMELEFT(SSovermap, encounter_cooldown) / 10] seconds."
	var/list/dynamic_encounter_values = SSovermap.spawn_dynamic_encounter(planet, TRUE, ruin_type = template)
	mapzone = dynamic_encounter_values[1]
	reserve_dock = dynamic_encounter_values[2]
	reserve_dock_secondary = dynamic_encounter_values[3]

/**
 * Alters the position and orientation of a stationary docking port to ensure that any mobile port small enough can dock within its bounds
 */
/obj/structure/overmap/dynamic/proc/adjust_dock_to_shuttle(obj/docking_port/stationary/dock_to_adjust, obj/docking_port/mobile/shuttle)
	// the shuttle's dimensions where "true height" measures distance from the shuttle's fore to its aft
	var/shuttle_true_height = shuttle.height
	var/shuttle_true_width = shuttle.width
	// if the port's location is perpendicular to the shuttle's fore, the "true height" is the port's "width" and vice-versa
	if(EWCOMPONENT(shuttle.port_direction))
		shuttle_true_height = shuttle.width
		shuttle_true_width = shuttle.height

	// the dir the stationary port should be facing (note that it points inwards)
	var/final_facing_dir = angle2dir(dir2angle(shuttle_true_height > shuttle_true_width ? EAST : NORTH)+dir2angle(shuttle.port_direction)+180)

	var/list/old_corners = dock_to_adjust.return_coords() // coords for "bottom left" / "top right" of dock's covered area, rotated by dock's current dir
	var/list/new_dock_location // TBD coords of the new location
	if(final_facing_dir == dock_to_adjust.dir)
		new_dock_location = list(old_corners[1], old_corners[2]) // don't move the corner
	else if(final_facing_dir == angle2dir(dir2angle(dock_to_adjust.dir)+180))
		new_dock_location = list(old_corners[3], old_corners[4]) // flip corner to the opposite
	else
		var/combined_dirs = final_facing_dir | dock_to_adjust.dir
		if(combined_dirs == (NORTH|EAST) || combined_dirs == (SOUTH|WEST))
			new_dock_location = list(old_corners[1], old_corners[4]) // move the corner vertically
		else
			new_dock_location = list(old_corners[3], old_corners[2]) // move the corner horizontally
		// we need to flip the height and width
		var/dock_height_store = dock_to_adjust.height
		dock_to_adjust.height = dock_to_adjust.width
		dock_to_adjust.width = dock_height_store

	dock_to_adjust.dir = final_facing_dir
	if(shuttle.height > dock_to_adjust.height || shuttle.width > dock_to_adjust.width)
		CRASH("Shuttle cannot fit in dock!")

	// offset for the dock within its area
	var/new_dheight = round((dock_to_adjust.height-shuttle.height)/2) + shuttle.dheight
	var/new_dwidth = round((dock_to_adjust.width-shuttle.width)/2) + shuttle.dwidth

	// use the relative-to-dir offset above to find the absolute position offset for the dock
	switch(final_facing_dir)
		if(NORTH)
			new_dock_location[1] += new_dwidth
			new_dock_location[2] += new_dheight
		if(SOUTH)
			new_dock_location[1] -= new_dwidth
			new_dock_location[2] -= new_dheight
		if(EAST)
			new_dock_location[1] += new_dheight
			new_dock_location[2] -= new_dwidth
		if(WEST)
			new_dock_location[1] -= new_dheight
			new_dock_location[2] += new_dwidth

	dock_to_adjust.forceMove(locate(new_dock_location[1], new_dock_location[2], dock_to_adjust.z))
	dock_to_adjust.dheight = new_dheight
	dock_to_adjust.dwidth = new_dwidth

/**
  * Unloads the reserve, deletes the linked docking port, and moves to a random location if there's no client-having, alive mobs.
  */
/obj/structure/overmap/dynamic/proc/unload_level()
	if(preserve_level)
		return

	if(mapzone)
		if(length(mapzone.get_mind_mobs()))
			return //Dont fuck over stranded people? tbh this shouldn't be called on this condition, instead of bandaiding it inside
		if(SSovermap.generator_type == OVERMAP_GENERATOR_SOLAR)
			forceMove(SSovermap.get_unused_overmap_square_in_radius())
		else
			forceMove(SSovermap.get_unused_overmap_square())
		choose_level_type()
		remove_mapzone()

	if(reserve_dock)
		qdel(reserve_dock, TRUE)
		reserve_dock = null
	if(reserve_dock_secondary)
		qdel(reserve_dock_secondary, TRUE)
		reserve_dock_secondary = null

/obj/structure/overmap/dynamic/empty
	name = "Empty Space"
	desc = "A ship appears to be docked here."
	icon_state = "object"

/obj/structure/overmap/dynamic/empty/choose_level_type()
	return

/obj/structure/overmap/dynamic/empty/unload_level()
	if(preserve_level)
		return

	// Duplicate code grrr
	if(length(mapzone.get_mind_mobs()))
		return //Dont fuck over stranded people? tbh this shouldn't be called on this condition, instead of bandaiding it inside

	remove_mapzone()
	qdel(src)

/obj/structure/overmap/dynamic/lava
	force_encounter = /datum/overmap/planet/lava

/obj/structure/overmap/dynamic/ice
	force_encounter = /datum/overmap/planet/ice

/obj/structure/overmap/dynamic/sand
	force_encounter = /datum/overmap/planet/sand

/obj/structure/overmap/dynamic/jungle
	force_encounter = /datum/overmap/planet/jungle

/obj/structure/overmap/dynamic/rock
	force_encounter = /datum/overmap/planet/rock

/obj/structure/overmap/dynamic/reebe
	force_encounter = /datum/overmap/planet/reebe

/obj/structure/overmap/dynamic/asteroid
	force_encounter = /datum/overmap/planet/asteroid

/obj/structure/overmap/dynamic/energy_signal
	force_encounter = /datum/overmap/planet/space

/area/overmap_encounter
	name = "\improper Overmap Encounter"
	icon_state = "away"
	area_flags = HIDDEN_AREA | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | NOTELEPORT
	flags_1 = CAN_BE_DIRTY_1
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	sound_environment = SOUND_ENVIRONMENT_STONEROOM
	ambientsounds = RUINS
	outdoors = TRUE

/area/overmap_encounter/planetoid
	name = "\improper Unknown Planetoid"
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS
	has_gravity = STANDARD_GRAVITY
	always_unpowered = TRUE

/area/overmap_encounter/planetoid/lava
	name = "\improper Volcanic Planetoid"
	ambientsounds = MINING

/area/overmap_encounter/planetoid/ice
	name = "\improper Frozen Planetoid"
	sound_environment = SOUND_ENVIRONMENT_CAVE
	ambientsounds = SPOOKY

/area/overmap_encounter/planetoid/sand
	name = "\improper Sandy Planetoid"
	sound_environment = SOUND_ENVIRONMENT_QUARRY
	ambientsounds = MINING

/area/overmap_encounter/planetoid/jungle
	name = "\improper Jungle Planetoid"
	sound_environment = SOUND_ENVIRONMENT_FOREST
	ambientsounds = AWAY_MISSION

/area/overmap_encounter/planetoid/rockplanet
	name = "\improper Rocky Planetoid"
	sound_environment = SOUND_ENVIRONMENT_HANGAR
	ambientsounds = MAINTENANCE

/area/overmap_encounter/planetoid/rockplanet/explored//for use in ruins
	area_flags = UNIQUE_AREA
	area_flags = VALID_TERRITORY | UNIQUE_AREA

/area/overmap_encounter/planetoid/reebe
	name = "\improper Yellow Space"
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS
	ambientsounds = REEBE

/area/overmap_encounter/planetoid/reebe/Entered(atom/movable/AM)
	. = ..()
	if(ismob(AM))
		var/mob/M = AM
		if(M.client)
			addtimer(CALLBACK(M.client, /client/proc/play_reebe_ambience), 900)
