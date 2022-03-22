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
	///Map of tiles at each radius (represented by index) around the sun
	var/list/list/radius_tiles
	///Planetary z levels
	var/list/planets = list()

	///Width/height of the overmap "zlevel"
	var/size = 17

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

	setup_events()

	spawn_overmap_planets()

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
	var/area/overmap/overmap_area = new
	overmap_area.setup("Overmap")
	var/list/overmap_turfs = block(locate(OVERMAP_MIN_X, OVERMAP_MIN_Y, OVERMAP_Z_LEVEL), locate(OVERMAP_MAX_X, OVERMAP_MAX_Y, OVERMAP_Z_LEVEL))
	for (var/turf/turf as anything in overmap_turfs)
		if (turf.x == OVERMAP_MIN_X || turf.x == OVERMAP_MAX_X || turf.y == OVERMAP_MIN_Y || turf.y == OVERMAP_MAX_Y)
			turf.ChangeTurf(/turf/closed/overmap_edge)
		else
			turf.ChangeTurf(/turf/open/overmap)
		overmap_area.contents += turf
	overmap_area.reg_in_areas_in_z()

///Creates new z levels for each planet
/datum/controller/subsystem/overmap/proc/spawn_overmap_planets()
	var/idx = 1
	for (var/i in 1 to planets_to_spawn)
		var/datum/overmap/planet/planet = pick_n_take(possible_planets)

		planet = new planet
		var/datum/space_level/planet_z = SSmapping.add_new_zlevel("Overmap planet [i]", planet.planet_ztraits)
		spawn_planet(planet, planet_z)
		planets[planet.ruin_type] = planet_z.z_value

		//issue here is that planets are now spawning on top of stuff. STOP TAHT!

		new /obj/structure/overmap/dynamic/lava(radius_tiles[rand(4,6)][idx])
		idx += rand(10, 25)



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

/datum/controller/subsystem/overmap/proc/setup_sun()
	var/obj/structure/overmap/star/big/centre = new // TODO set this up to choose a random medium, big or binary
	var/sun_loc = locate(size / 2, OVERMAP_MIN_Y + (size / 2), 1)
	centre.forceMove(sun_loc)
	new /obj/effect/landmark/observer_start(sun_loc)

	//setup radius tiles
	var/list/unsorted_turfs = get_areatype_turfs(/area/overmap)
	radius_tiles = list()
	for (var/i in 1 to (size - 2) / 2)
		radius_tiles += list(list())
		for (var/turf/turf in unsorted_turfs)
			var/dist = round(sqrt((turf.x - (centre.x + 1)) ** 2 + (turf.y - (centre.y + 1)) ** 2))
			if (dist != i)
				continue
			radius_tiles[i] += turf
			unsorted_turfs -= turf

/datum/controller/subsystem/overmap/proc/get_unused_overmap_square_in_radius(radius, obj_to_avoid = /obj/structure/overmap, tries = MAX_OVERMAP_PLACEMENT_ATTEMPTS, force = FALSE)
	if (!radius)
		radius = rand(2, LAZYLEN(radius_tiles))

	for (var/i in 1 to tries)
		. = pick(radius_tiles[radius])
		if (locate(obj_to_avoid) in .)
			continue
		return

	if (!force)
		. = null

/datum/controller/subsystem/overmap/proc/setup_dangers()
	var/list/orbits = list()
	for (var/i in 2 to LAZYLEN(radius_tiles))
		orbits += "[i]"

	var/max_clusters = MAX_OVERMAP_EVENT_CLUSTERS
	for (var/i in 1 to max_clusters)
		if (MAX_OVERMAP_EVENTS <= LAZYLEN(events))
			return
		if (LAZYLEN(orbits) == 0 || !orbits)
			break // can't fit anymore in
		var/event_type = pick_weight(GLOB.overmap_event_pick_list)
		var/selected_orbit = text2num(pick(orbits))

		var/turf/turf = get_unused_overmap_square_in_radius(selected_orbit)

		if (!turf || !istype(turf))
			orbits -= "[selected_orbit]" // this one is full
			continue

		var/obj/structure/overmap/event/event = new event_type(turf)
		for (var/turf/turf_to_spawn as anything in radius_tiles[selected_orbit])
			if (locate(/obj/structure/overmap) in turf_to_spawn)
				continue
			if (!prob(event.spread_chance))
				continue
			new event_type(turf_to_spawn)

/datum/controller/subsystem/overmap/proc/setup_events()
	setup_sun()
	setup_dangers()



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
