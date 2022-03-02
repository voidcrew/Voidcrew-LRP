/turf/open/floor/plating/grass/jungle/lit
	light_range = 2
	light_power = 1
/turf/open/floor/plating/dirt/jungle/dark/lit
	light_range = 2
	light_power = 1
/turf/open/floor/plating/dirt/jungle/wasteland/lit
	light_range = 2
	light_power = 1
/turf/open/water/jungle/lit
	light_range = 2
	light_power = 0.8
	light_color = LIGHT_COLOR_BLUEGREEN
/turf/open/floor/plating/dirt/old
	icon_state = "oldsmoothdirt"
/turf/open/floor/plating/dirt/old/lit
	light_power = 1
	light_range = 2
/turf/open/floor/plating/dirt/old/dark
	icon_state =  "oldsmoothdarkdirt"
/turf/open/floor/plating/dirt/old/dark/lit
	light_power = 1
	light_range = 2

/turf/open/floor/plating/dirt/dry
	icon = 'voidcrew/icons/turf/civ13-floors.dmi'
	icon_state = "dirt"
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/dirt/dry

/turf/open/floor/plating/dirt/dry/lit
	light_power = 1
	light_range = 2

/turf/open/floor/plating/grass/lava
	name = "lava grass"
	baseturfs = /turf/open/floor/plating/grass/lava
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	planetary_atmos = TRUE
	desc = "Smells like burnt hair."
	icon_state = "grass"
	base_icon_state = "grass"
	smooth_icon = 'voidcrew/icons/turf/floors/lava_grass_red.dmi'
	layer = MID_TURF_LAYER
	light_power = 1
	light_range = 2

/turf/open/floor/plating/grass/lava/orange
	smooth_icon = 'voidcrew/icons/turf/floors/lava_grass_orange.dmi'
	baseturfs = /turf/open/floor/plating/grass/lava/orange

/turf/open/floor/plating/grass/lava/purple
	baseturfs = /turf/open/floor/plating/grass/lava/purple
	smooth_icon = 'voidcrew/icons/turf/floors/lava_grass_purple.dmi'

/turf/open/floor/plating/wasteland
	icon = 'voidcrew/icons/turf/floors/wasteland.dmi'
	icon_state = "wasteland1"
	base_icon_state = "wasteland"
	baseturfs = /turf/open/floor/plating/wasteland

/turf/open/floor/plating/wasteland/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[base_icon_state][rand(1,33)]"

/turf/open/floor/plating/wasteland/lit
	light_power = 1
	light_range = 2

/turf/open/floor/plating/rubble
	icon = 'voidcrew/icons/turf/wasteland-floors.dmi'
	icon_state = "rubblefull"
	base_icon_state = "rubble"
	baseturfs = /turf/open/floor/plating/rubble

/turf/open/floor/plating/rubble/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[base_icon_state][pick("full", "slab", "plate", "pillar")]"

/turf/open/floor/plating/tunnel
	icon = 'voidcrew/icons/turf/wasteland-floors.dmi'
	icon_state = "tunnelintact"
	base_icon_state = "tunnel"
	baseturfs = /turf/open/floor/plating/tunnel

/turf/open/floor/plating/tunnel/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[base_icon_state][pick("intact", "dirty", "rusty", "chess", "chess2", "hole", "wastelandfull", "wastelandfullvar", "wasteland")]"

/turf/open/floor/plating/mossy_stone
	icon = 'voidcrew/icons/turf/civ13-floors.dmi'
	icon_state = "stone_old"
	base_icon_state = "stone"
	baseturfs = /turf/open/floor/plating/mossy_stone

/turf/open/floor/plating/stone/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[base_icon_state]_[pick("old", "old1", "old2")]"

/turf/open/floor/plating/dust
	icon = 'voidcrew/icons/turf/civ13-floors.dmi'
	icon_state = "dust1"
	base_icon_state = "dust"
	baseturfs = /turf/open/floor/plating/dust

/turf/open/floor/plating/dust/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[base_icon_state][pick("1", "2")]"

/turf/open/floor/plating/dust/lit
	light_power = 1
	light_range = 2

/turf/open/floor/plating/sand
	icon = 'voidcrew/icons/turf/civ13-beach.dmi'
	icon_state = "desert0"
	base_icon_state = "desert"
	light_range = 2
	light_power = 1
	baseturfs = /turf/open/floor/plating/sand

/turf/open/floor/plating/sand/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[base_icon_state][rand(0,5)]"

/turf/open/floor/plating/sand/dark
	icon_state = "desert6"

/turf/open/floor/plating/sand/dark/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[base_icon_state][rand(6,8)]"
