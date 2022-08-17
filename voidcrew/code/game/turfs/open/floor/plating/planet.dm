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
	icon = 'voidcrew/icons/turf/wasteland.dmi'
	icon_state = "dirt"
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/dirt/dry

/turf/open/floor/plating/dirt/dry/lit
	light_power = 1
	light_range = 2

/turf/open/floor/plating/grass/lava
	name = "ungodly grass"
	desc = "Common grass, tinged to unnatural colours by chemicals in the atmosphere."
	baseturfs = /turf/open/floor/plating/grass/lava
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	icon_state = "grass"
	base_icon_state = "grass"
	planetary_atmos = TRUE
	smooth_icon = 'voidcrew/icons/turf/floors/lava_grass_red.dmi'
	light_power = 1
	light_range = 2
	gender = PLURAL

/turf/open/floor/plating/grass/lava/orange
	smooth_icon = 'voidcrew/icons/turf/floors/lava_grass_orange.dmi'
	baseturfs = /turf/open/floor/plating/grass/lava/orange

/turf/open/floor/plating/grass/lava/purple
	baseturfs = /turf/open/floor/plating/grass/lava/purple
	smooth_icon = 'voidcrew/icons/turf/floors/lava_grass_purple.dmi'

/turf/open/floor/plating/wasteland
	name = "desolate ground"
	desc = "Devoid of all but the most hardy lifeforms."
	icon = 'voidcrew/icons/turf/wasteland.dmi'
	icon_state = "wasteland1"
	base_icon_state = "wasteland"
	baseturfs = /turf/open/floor/plating/wasteland
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	gender = PLURAL

/turf/open/floor/plating/wasteland/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[base_icon_state][rand(1,33)]"

/turf/open/floor/plating/wasteland/lit
	light_power = 1
	light_range = 2

/turf/open/floor/plating/rubble
	name = "rubble"
	desc = "Rubble from a destroyed civilization."
	icon = 'voidcrew/icons/turf/wasteland.dmi'
	icon_state = "rubblefull"
	base_icon_state = "rubble"
	baseturfs = /turf/open/floor/plating/rubble
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	gender = PLURAL

/turf/open/floor/plating/rubble/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[base_icon_state][pick("full", "slab", "plate", "pillar")]"

/turf/open/floor/plating/tunnel
	name = "plating"
	desc = "The foundations of some structure that never came to fruition."
	icon = 'voidcrew/icons/turf/wasteland.dmi'
	icon_state = "tunnelintact"
	base_icon_state = "tunnel"
	baseturfs = /turf/open/floor/plating/tunnel
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	gender = PLURAL

/turf/open/floor/plating/tunnel/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[base_icon_state][pick("intact", "dirty", "rusty", "chess", "chess2", "hole", "wastelandfull", "wastelandfullvar", "wasteland")]"

/turf/open/floor/plating/mossy_stone
	name = "mossy stone"
	desc = "Ancient stone with moss growing on it."
	icon = 'voidcrew/icons/turf/wasteland.dmi'
	icon_state = "stone_old"
	base_icon_state = "stone"
	baseturfs = /turf/open/floor/plating/mossy_stone
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	gender = PLURAL

/turf/open/floor/plating/stone/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[base_icon_state]_[pick("old", "old1", "old2")]"

/turf/open/floor/plating/dust
	name = "dry ground"
	desc = "Dust perpetually blows through this land."
	icon = 'voidcrew/icons/turf/wasteland.dmi'
	icon_state = "dust1"
	base_icon_state = "dust"
	baseturfs = /turf/open/floor/plating/dust
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	gender = PLURAL

/turf/open/floor/plating/dust/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[base_icon_state][pick("1", "2")]"

/turf/open/floor/plating/dust/lit
	light_power = 1
	light_range = 2
