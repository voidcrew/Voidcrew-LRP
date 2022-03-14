/turf/open/floor/plating/asteroid/snow/breathable
	planetary_atmos = TRUE
	slowdown = 0

/turf/open/floor/plating/asteroid/snow/breathable/lit
	light_range = 2
	light_power = 1

/turf/open/floor/plating/asteroid/snow/under
	icon_state = "snow_dug"
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/snow/under/lit
	light_range = 2
	light_power = 1

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/lit
	light_power = 0.55
	light_range = 2

/turf/open/floor/plating/asteroid/basalt/purple
	icon = 'voidcrew/icons/turf/lavaland_purple.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/basalt/purple
	turf_type = /turf/open/floor/plating/asteroid/basalt/purple
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/basalt/purple/lit
	light_power = 1
	light_range = 2

/turf/open/floor/plating/asteroid/purple
	name = "ashen sand"
	desc = "Sand, tinted by the chemicals in the atmosphere to an uncanny shade of purple."
	icon = 'voidcrew/icons/turf/lavaland_purple.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/purple
	turf_type = /turf/open/floor/plating/asteroid/basalt/purple
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/purple/lit
	light_power = 1
	light_range = 2

/turf/open/floor/plating/asteroid/sand
	name = "sand"
	icon = 'voidcrew/icons/turf/wasteland.dmi'
	icon_state = "desert"
	environment_type = "desert"
	base_icon_state = "desert"
	baseturfs = /turf/open/floor/plating/asteroid/sand
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	digResult = /obj/item/stack/ore/glass
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/sand/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[base_icon_state][rand(0,5)]"

/turf/open/floor/plating/asteroid/sand/lit
	light_range = 2
	light_power = 1

/turf/open/floor/plating/asteroid/sand/dark
	icon_state = "desert6"

/turf/open/floor/plating/asteroid/sand/dark/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[base_icon_state][rand(6,8)]"

/turf/open/floor/plating/asteroid/sand/dark/lit
	light_range = 2
	light_power = 1

/turf/open/floor/plating/asteroid/sand/beach
	planetary_atmos = TRUE
	icon = 'voidcrew/icons/misc/beach.dmi'
	icon_state = "sand"
	base_icon_state = "sand"
	environment_type = "sand"

/turf/open/floor/plating/asteroid/sand/beach/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[base_icon_state]"

/turf/open/floor/plating/asteroid/sand/beach/lit
	light_range = 2
	light_power = 0.80
	light_color = LIGHT_COLOR_TUNGSTEN

/turf/open/floor/plating/asteroid/sand/beach/dense
	icon_state = "light_sand"
	planetary_atmos = TRUE
	base_icon_state = "light_sand"

/turf/open/floor/plating/asteroid/sand/beach/dense/lit
	light_range = 2
	light_power = 0.80
	light_color = LIGHT_COLOR_TUNGSTEN
