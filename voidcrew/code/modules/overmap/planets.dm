/datum/overmap/planet
	///Name of the planet
	var/name = "Planet"
	///Description of the planet
	var/desc = "A generic planet, tell the Coders that you found this."
	///Icon of the planet
	var/icon_state = "globe"
	///Colour of the planet
	var/color = COLOR_WHITE

	///Planet spawn rate
	var/spawn_rate = 20
	///Overmap planet type
	var/planet = DYNAMIC_WORLD_ASTEROID

	/* Planet Generation */
	///The list of ruins that can spawn here
	var/list/ruin_list
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
	planet = DYNAMIC_WORLD_LAVA

	mapgen = /datum/map_generator/cave_generator/lavaland
	target_area = /area/overmap_encounter/planetoid/lava
	surface = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	weather_controller_type = /datum/weather_controller/lavaland

/datum/overmap/planet/lava/New()
	ruin_list = SSmapping.lava_ruins_templates

/datum/overmap/planet/ice
	name = "strange ice planet"
	desc = "A very weak energy signal originating from a planet with traces of water and extremely low temperatures."
	color = COLOR_BLUE_LIGHT
	planet = DYNAMIC_WORLD_ICE

	mapgen = /datum/map_generator/cave_generator/icemoon
	target_area = /area/overmap_encounter/planetoid/ice
	surface = /turf/open/floor/plating/asteroid/snow/icemoon
	weather_controller_type = /datum/weather_controller/snow_planet

/datum/overmap/planet/ice/New()
	ruin_list = SSmapping.ice_ruins_templates

/datum/overmap/planet/sand
	name = "strange sand planet"
	desc = "A very weak energy signal originating from a planet with many traces of silica."
	color = COLOR_GRAY
	planet = DYNAMIC_WORLD_SAND

	mapgen = /datum/map_generator/cave_generator/whitesands
	target_area = /area/overmap_encounter/planetoid/sand
	surface = /turf/open/floor/plating/asteroid/whitesands
	weather_controller_type = /datum/weather_controller/desert

/datum/overmap/planet/sand/New()
	ruin_list = SSmapping.sand_ruins_templates

/datum/overmap/planet/jungle
	name = "strange jungle planet"
	desc = "A very weak energy signal originating from a planet teeming with life."
	color = COLOR_LIME
	planet = DYNAMIC_WORLD_JUNGLE

	mapgen = /datum/map_generator/jungle_generator
	target_area = /area/overmap_encounter/planetoid/jungle
	surface = /turf/open/floor/plating/dirt/jungle
	weather_controller_type = /datum/weather_controller/lush

/datum/overmap/planet/jungle/New()
	ruin_list = SSmapping.jungle_ruins_templates

/datum/overmap/planet/rock
	name = "strange rock planet"
	desc = "A very weak energy signal originating from a abandoned industrial planet."
	color = COLOR_BROWN
	planet = DYNAMIC_WORLD_ROCKPLANET

	mapgen = /datum/map_generator/cave_generator/rockplanet
	target_area = /area/overmap_encounter/planetoid/rockplanet
	surface = /turf/open/floor/plating/asteroid
	weather_controller_type = /datum/weather_controller/chlorine

/datum/overmap/planet/rock/New()
	ruin_list = SSmapping.rock_ruins_templates

/datum/overmap/planet/reebe
	name = "???"
	desc = "Some sort of strange portal. Theres no identification of what this is."
	color = COLOR_YELLOW
	planet = DYNAMIC_WORLD_REEBE
	icon_state = "wormhole"
	spawn_rate = -1

	mapgen = /datum/map_generator/cave_generator/reebe
	target_area = /area/overmap_encounter/planetoid/reebe
	surface = /turf/open/chasm/reebe_void

/datum/overmap/planet/reebe/New()
	ruin_list = SSmapping.yellow_ruins_templates

/datum/overmap/planet/asteroid
	name = "large asteroid"
	desc = "A large asteroid with significant traces of minerals."
	color = COLOR_GRAY
	planet = DYNAMIC_WORLD_ASTEROID
	icon_state = "asteroid"
	spawn_rate = 30

	ruin_list = null
	mapgen = /datum/map_generator/cave_generator/asteroid

/datum/overmap/planet/space // not a planet but freak off!!
	name = "weak energy signal"
	desc = "A very weak energy signal emenating from space."
	color = null
	planet = DYNAMIC_WORLD_SPACERUIN
	icon_state = "strange_event"

/datum/overmap/planet/space/New()
	ruin_list = SSmapping.space_ruins_templates
