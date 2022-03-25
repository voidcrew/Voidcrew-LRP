#define INIT_ANNOUNCE(X) to_chat(world, span_boldannounce("[X]")); log_world(X)

#define MAX_OVERMAP_EVENT_CLUSTERS 8
#define MAX_OVERMAP_EVENTS 120


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
	///List of space z zones
	var/list/space_z_zones = list()

	///Width/height of the overmap "zlevel"
	var/size = 23

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

///Generates the planeat on a given z level
/datum/controller/subsystem/overmap/proc/spawn_planet(datum/overmap/planet/planet_type, planet_num)
	var/datum/space_level/z_level = SSmapping.add_new_zlevel("Overmap planet [planet_num]", planet_type.planet_ztraits)

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

	planets[planet_type.ruin_type] = z_level.z_value
	return z_level.z_value

/datum/controller/subsystem/overmap/proc/spawn_space_level(planet_num)
	var/datum/space_level/z_level = SSmapping.add_new_zlevel("Space zone [planet_num]", list(ZTRAIT_SPACE_RUINS = TRUE, ZTRAIT_BASETURF = /turf/open/space))

	if (prob(25))
		seedRuins(list(z_level.z_value), 10, /area/space, SSmapping.themed_ruins[ZTRAIT_SPACE_RUINS])
	return z_level.z_value

/datum/controller/subsystem/overmap/proc/setup_planet(obj/structure/overmap/dynamic/planet_object, datum/overmap/planet/planet)
	planet_object.name = planet.name
	planet_object.desc = planet.desc
	planet_object.icon_state = planet.icon_state
	planet_object.color = planet.color

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
	for (var/i in 1 to planets_to_spawn)
		var/datum/overmap/planet/planet = pick(possible_planets)
		planet = new planet
		//VOID TODO: planets should really be spawning far apart, need some sort of proc that will find a turf that is far from other planets
		var/outer_radii = LAZYLEN(radius_tiles)
		var/obj/structure/overmap/dynamic/planet_object = new(get_unused_overmap_square_in_radius(rand(outer_radii - 3, outer_radii), force = TRUE))
		planet_object.linked_zlevel = spawn_planet(planet, i) // spawn the planet here, and link it to the planet
		setup_planet(planet_object, planet)

/datum/controller/subsystem/overmap/proc/setup_sun()
	var/obj/structure/overmap/star/big/centre = new // TODO set this up to choose a random medium, big or binary
	var/sun_loc = locate(size / 2, (OVERMAP_MIN_Y - 1) + (size / 2), 1)
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

/datum/controller/subsystem/overmap/proc/get_unused_overmap_square_in_radius(radius, obj_to_avoid = /obj/structure/overmap, force = FALSE)
	if (!radius)
		radius = rand(2, LAZYLEN(radius_tiles))

	while (TRUE)
		. = pick(radius_tiles[radius])
		var/obj/structure/overmap/obj = locate(obj_to_avoid) in .
		if (force && obj)
			qdel(obj)
			return
		if (obj)
			continue
		return

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


/datum/controller/subsystem/overmap/proc/setup_space()
	var/z_zone = 1
	var/last_zone = z_zone
	for (var/i in (OVERMAP_MIN_X + 1) to (OVERMAP_MAX_X - 1))
		for (var/j in (OVERMAP_MIN_Y + 1) to (OVERMAP_MAX_Y - 1))
			var/turf/open/overmap/overmap = locate(i, j, OVERMAP_Z_LEVEL)
			overmap.z_zone = z_zone
			overmap.name = "[i]-[j]"

			if (((OVERMAP_MIN_Y) - j) % 3 == 0)
				overmap.z_zone = spawn_space_level(z_zone) // setup space and assign the z to it
				z_zone += 1

		if ((i - 1) % 3 == 0)
			last_zone = z_zone
		else
			z_zone = last_zone

/datum/controller/subsystem/overmap/proc/setup_events()
	setup_sun()
	setup_dangers()
	setup_space()


//VOID TODO setup SSovermap recover

#undef INIT_ANNOUNCE
#undef MAX_OVERMAP_EVENTS
#undef MAX_OVERMAP_EVENT_CLUSTERS
