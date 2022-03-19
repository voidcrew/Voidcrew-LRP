#define INIT_ANNOUNCE(X) to_chat(world, span_boldannounce("[X]")); log_world(X)

#define MAX_OVERMAP_EVENT_CLUSTERS 10
#define MAX_OVERMAP_EVENTS 150

#define BOTTOM_LEFT_TURF locate(OVERMAP_MIN_X, OVERMAP_MIN_Y, OVERMAP_Z_LEVEL)

SUBSYSTEM_DEF(overmap)
	name = "Overmap"
	wait = 10
	init_order = INIT_ORDER_OVERMAP
	flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_SETUP | RUNLEVEL_GAME

	//The type of star this system will have
	var/startype

	///List of all overmap objects.
	var/list/overmap_objects
	///List of all events
	var/list/events
	///List of all ships
	var/list/simulated_ships

	///Width/height of the overmap "zlevel"
	var/size = 18

	///Cooldown on dynamically loading encounters

	///Planet spawning probability
	var/static/list/possible_planets = list()

	///Number of initial ships to spawn in
	var/initial_ship_count = 1

	var/planets_to_spawn = 5

/**
  * Creates an overmap object for shuttles, triggers initialization procs for ships
  */
/datum/controller/subsystem/overmap/Initialize(start_timeofday)
	overmap_objects = list()
	events = list()

	generate_probabilites()

	create_map()

	spawn_overmap_planets()

	// spawn in all of the events + overmap planets here

	return ..()

/datum/controller/subsystem/overmap/fire()
	for(var/obj/structure/overmap/event/event as anything in events)
		if(event?.affect_multiple_times && event?.close_overmap_objects)
			event.apply_effect()

/datum/controller/subsystem/overmap/proc/generate_probabilites()
	for (var/path in subtypesof(/datum/overmap/planet))
		var/datum/overmap/planet/temp_planet = new path
		possible_planets |= list(temp_planet.type = min(length(SSmapping.themed_ruins[temp_planet.ruin_type]), temp_planet.spawn_rate))
		qdel(temp_planet)

/datum/controller/subsystem/overmap/proc/create_map()
	var/list/overmap_turfs = block(locate(OVERMAP_MIN_X, OVERMAP_MIN_Y, OVERMAP_Z_LEVEL), locate(OVERMAP_MAX_X, OVERMAP_MAX_Y, OVERMAP_Z_LEVEL))
	for (var/turf/turf as anything in overmap_turfs)
		if (turf.x == OVERMAP_MIN_X || turf.x == OVERMAP_MAX_X || turf.y == OVERMAP_MIN_Y || turf.y == OVERMAP_MAX_Y)
			turf.ChangeTurf(/turf/closed/overmap_edge)
		else
			turf.ChangeTurf(/turf/open/overmap)

///Creates new z levels for each planet
/datum/controller/subsystem/overmap/proc/spawn_overmap_planets()
	for (var/i in 1 to planets_to_spawn)
		var/datum/overmap/planet/planet = pick_n_take(possible_planets)

		planet = new planet
		var/datum/space_level/planet_z = SSmapping.add_new_zlevel("Overmap planet [i]", planet.planet_ztraits)
		spawn_planet(planet, planet_z)

///Generates the planeat on a given z level
/datum/controller/subsystem/overmap/proc/spawn_planet(datum/overmap/planet/planet_type, datum/space_level/z_level)
	var/ruin_type = planet_type.ruin_type
	var/turf/surface = planet_type.surface
	var/datum/map_generator/mapgen = planet_type?.mapgen

	// set all of the area vars
	var/area/area = new planet_type.planet_area
	area.area_flags |= planet_type.area_flags
	area.ambientsounds = planet_type.ambientsounds
	area.sound_environment = planet_type.sound_environment
	area.setup(planet_type.area_name)

	// Fill the whole are with turfs and setup the area
	var/list/turfs = Z_TURFS(z_level.z_value)
	for (var/turf/turf as anything in turfs)
		turf.ChangeTurf(surface, surface)
		area.contents += turf
	area.reg_in_areas_in_z()

	//run ruin and mapgen
	if (SSmapping.themed_ruins[ruin_type])
		seedRuins(list(z_level.z_value), planet_type.spawn_rate, list(planet_type.planet_area), SSmapping.themed_ruins[ruin_type])
	if (!isnull(mapgen))
		area.map_generator = mapgen
		area.RunGeneration()

/datum/controller/subsystem/overmap/proc/setup_events()
	//first we have to spawn a sun

	//then events

/*
/datum/controller/subsystem/overmap/Recover()
	if(istype(SSovermap.events))
		events = SSovermap.events
	if(istype(SSovermap.radius_tiles))
		radius_tiles = SSovermap.radius_tiles
*/

#undef INIT_ANNOUNCE
#undef MAX_OVERMAP_EVENTS
#undef MAX_OVERMAP_EVENT_CLUSTERS
