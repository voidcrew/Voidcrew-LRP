/datum/overmap/planet
	///Name of the planet
	var/name = "Planet"
	///Description of the planet
	var/desc = "A generic planet, tell the Coders that you found this."
	///Icon of the planet
	var/icon_state = "globe"
	///Colour of the planet
	var/color = COLOR_WHITE

	/* Planet Generation */
	///Planet spawn rate
	var/spawn_rate = 20
	///The list of ruins that can spawn here
	var/ruin_type
	///The area the ruin needs
	var/area/ruin_area

	///The map generator to use
	var/datum/map_generator/mapgen
	///The surface turf
	var/turf/surface = /turf/open/space

	var/list/planet_ztraits

/datum/overmap/planet/lava
	name = "strange lava planet"
	desc = "A very weak energy signal originating from a planet with lots of seismic and volcanic activity."
	color = COLOR_ORANGE

	planet_ztraits = list(
		ZTRAIT_ASHSTORM = TRUE,
		ZTRAIT_LAVA_RUINS = TRUE,
		ZTRAIT_BASETURF = /turf/open/lava/smooth/lava_land_surface,
	)

	ruin_type = ZTRAIT_LAVA_RUINS
	surface = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	mapgen = /datum/map_generator/cave_generator/lavaland

/datum/overmap/planet/ice
	name = "strange ice planet"
	desc = "A very weak energy signal originating from a planet with traces of water and extremely low temperatures."
	color = COLOR_BLUE_LIGHT

	planet_ztraits = list(
		//VOID TODO weather type
		ZTRAIT_ICE_RUINS = TRUE,
		ZTRAIT_BASETURF = /turf/open/floor/plating/asteroid/snow/icemoon,
	)

	ruin_type = ZTRAIT_ICE_RUINS
	mapgen = /datum/map_generator/cave_generator/icemoon
	surface = /turf/open/floor/plating/asteroid/snow/icemoon

/datum/overmap/planet/sand
	name = "strange sand planet"
	desc = "A very weak energy signal originating from a planet with many traces of silica."
	color = COLOR_GRAY

	planet_ztraits = list(
		//VOID TODO Weather type
		ZTRAIT_SAND_RUINS = TRUE,
		ZTRAIT_BASETURF = /turf/open/floor/plating/asteroid/whitesands,
	)

	ruin_type = ZTRAIT_SAND_RUINS
	// mapgen = /datum/map_generator/cave_generator/whitesands
	surface = /turf/open/floor/plating/asteroid/whitesands

/datum/overmap/planet/jungle
	name = "strange jungle planet"
	desc = "A very weak energy signal originating from a planet teeming with life."
	color = COLOR_LIME

	planet_ztraits = list(
		//VOID TODO WEATHER
		ZTRAIT_JUNGLE_RUINS = TRUE,
		ZTRAIT_BASETURF = /turf/open/floor/plating/dirt,
	)

	ruin_type = ZTRAIT_JUNGLE_RUINS
	// mapgen = /datum/map_generator/jungle_generator
	surface = /turf/open/floor/plating/dirt/jungle

/datum/overmap/planet/rock
	name = "strange rock planet"
	desc = "A very weak energy signal originating from a abandoned industrial planet."
	color = COLOR_BROWN

	planet_ztraits = list(
		//VOID TODO WEATHER
		ZTRAIT_ROCK_RUINS = TRUE,
		ZTRAIT_BASETURF = /turf/open/floor/plating/asteroid
	)

	ruin_type = ZTRAIT_ROCK_RUINS
	// mapgen = /datum/map_generator/cave_generator/rockplanet
	surface = /turf/open/floor/plating/asteroid

/*
/datum/overmap/planet/asteroid
	name = "large asteroid"
	desc = "A large asteroid with significant traces of minerals."
	color = COLOR_GRAY
	icon_state = "asteroid"

	spawn_rate = 30
	mapgen = /datum/map_generator/cave_generator/asteroid
*/

/datum/overmap/planet/space // not a planet but freak off!!
	name = "weak energy signal"
	desc = "A very weak energy signal emenating from space."
	color = null
	icon_state = "strange_event"

	planet_ztraits = list (
		ZTRAIT_SPACE_RUINS = TRUE
	)

	ruin_type = ZTRAIT_SPACE_RUINS

