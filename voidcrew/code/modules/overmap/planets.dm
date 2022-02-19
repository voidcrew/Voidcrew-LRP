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
	///The map generator to use
	var/datum/map_generator/mapgen
	///The area type to use on the planet
	var/area/target_area
	///The surface turf
	var/turf/surface = /turf/open/space
	///Weather controller for planet specific weather
	var/datum/weather_controller/weather_controller_type

/datum/overmap/planet/lava
	name = "strange lava planet"
	desc = "A very weak energy signal originating from a planet with lots of seismic and volcanic activity."
	color = COLOR_ORANGE

	ruin_type = RUIN_TYPE_LAVA
	mapgen = /datum/map_generator/cave_generator/lavaland
	target_area = /area/overmap_encounter/planetoid/lava
	surface = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	weather_controller_type = /datum/weather_controller/lavaland

/datum/overmap/planet/ice
	name = "strange ice planet"
	desc = "A very weak energy signal originating from a planet with traces of water and extremely low temperatures."
	color = COLOR_BLUE_LIGHT

	ruin_type = RUIN_TYPE_ICE
	mapgen = /datum/map_generator/cave_generator/icemoon
	target_area = /area/overmap_encounter/planetoid/ice
	surface = /turf/open/floor/plating/asteroid/snow/icemoon
	weather_controller_type = /datum/weather_controller/snow_planet

/datum/overmap/planet/sand
	name = "strange sand planet"
	desc = "A very weak energy signal originating from a planet with many traces of silica."
	color = COLOR_GRAY

	ruin_type = RUIN_TYPE_SAND
	mapgen = /datum/map_generator/cave_generator/whitesands
	target_area = /area/overmap_encounter/planetoid/sand
	surface = /turf/open/floor/plating/asteroid/whitesands
	weather_controller_type = /datum/weather_controller/desert

/datum/overmap/planet/jungle
	name = "strange jungle planet"
	desc = "A very weak energy signal originating from a planet teeming with life."
	color = COLOR_LIME

	ruin_type = RUIN_TYPE_JUNGLE
	mapgen = /datum/map_generator/jungle_generator
	target_area = /area/overmap_encounter/planetoid/jungle
	surface = /turf/open/floor/plating/dirt/jungle
	weather_controller_type = /datum/weather_controller/lush

/datum/overmap/planet/rock
	name = "strange rock planet"
	desc = "A very weak energy signal originating from a abandoned industrial planet."
	color = COLOR_BROWN

	ruin_type = RUIN_TYPE_ROCK
	mapgen = /datum/map_generator/cave_generator/rockplanet
	target_area = /area/overmap_encounter/planetoid/rockplanet
	surface = /turf/open/floor/plating/asteroid
	weather_controller_type = /datum/weather_controller/chlorine

/datum/overmap/planet/reebe
	name = "???"
	desc = "Some sort of strange portal. Theres no identification of what this is."
	color = COLOR_YELLOW
	icon_state = "wormhole"

	ruin_type = RUIN_TYPE_REEBE
	spawn_rate = -1 // disabled because reebe sucks for natural gen
	mapgen = /datum/map_generator/cave_generator/reebe
	target_area = /area/overmap_encounter/planetoid/reebe
	surface = /turf/open/chasm/reebe_void

/datum/overmap/planet/asteroid
	name = "large asteroid"
	desc = "A large asteroid with significant traces of minerals."
	color = COLOR_GRAY
	icon_state = "asteroid"

	spawn_rate = 30
	mapgen = /datum/map_generator/cave_generator/asteroid

/datum/overmap/planet/space // not a planet but freak off!!
	name = "weak energy signal"
	desc = "A very weak energy signal emenating from space."
	color = null
	icon_state = "strange_event"

	ruin_type = RUIN_TYPE_SPACE
