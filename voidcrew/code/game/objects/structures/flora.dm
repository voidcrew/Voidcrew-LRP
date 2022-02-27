/obj/structure/flora/firebush
	name = "flaming bush"
	desc = "It hurts to look at"
	icon = 'voidcrew/icons/obj/flora/hellflora.dmi'
	icon_state = "hell_bush"
	density = FALSE
	light_color = "#e08300"
	light_power = 2
	light_range = 3
	resistance_flags = LAVA_PROOF

/obj/structure/flora/tree/dead/hell
	name = "lava tree"
	icon = 'voidcrew/icons/obj/flora/lavatrees.dmi'
	desc = "It's seriously hampering your view of the wastes."
	pixel_x = -16
	light_color = LIGHT_COLOR_BLOOD_MAGIC
	light_range = 2
	light_power = 0.85
	resistance_flags = LAVA_PROOF

/obj/structure/flora/ausbushes/fullgrass/hell
	name = "thick hellish grass"
	desc = "a thick patch of burning grass"
	icon = 'voidcrew/icons/obj/flora/hellflora.dmi'
	light_range = 2
	light_power = 3
	resistance_flags = LAVA_PROOF

/obj/structure/flora/ausbushes/fullgrass/hell/Initialize()
	icon_state = "fullgrass_[rand(1, 3)]"
	light_color = pick("#e87800", "#780606")
	. = ..()

/obj/structure/flora/ausbushes/sparsegrass/hell
	name = "sparse hellish grass"
	desc = "a sparse patch of burning grass"
	icon = 'voidcrew/icons/obj/flora/hellflora.dmi'
	light_range = 2
	light_power = 3
	resistance_flags = LAVA_PROOF

/obj/structure/flora/ausbushes/sparsegrass/hell/Initialize()
	icon_state = "sparsegrass_[rand(1, 3)]"
	light_color = pick("#e87800", "#780606")
	. = ..()

/obj/structure/flora/ausbushes/grassybush/hell
	name = "hellish bush"
	desc = "a burning bush. not religious."
	icon = 'voidcrew/icons/obj/flora/hellflora.dmi'
	light_color = "#c70404"
	light_range = 2
	light_power = 3
	resistance_flags = LAVA_PROOF

/obj/structure/flora/ausbushes/hell
	name = "hellish prickly bush"
	desc = "some kind of plant"
	icon = 'voidcrew/icons/obj/flora/hellflora.dmi'
	light_range = 2
	light_power = 1
	resistance_flags = LAVA_PROOF

/obj/structure/flora/ausbushes/hell/Initialize()
	if(icon_state == "firstbush_1")
		icon_state = "firstbush_[rand(1, 4)]"
	light_color = pick("#e87800", "#780606")
	. = ..()

/obj/structure/flora/ausbushes/fernybush/hell
	icon = 'voidcrew/icons/obj/flora/hellflora.dmi'
	light_range = 2
	light_power = 1
	resistance_flags = LAVA_PROOF

/obj/structure/flora/ausbushes/fernybush/hell/Initialize()
	icon_state = "fernybush_[rand(1, 3)]"
	light_color = pick("#e87800", "#780606")
	. = ..()

/obj/structure/flora/ausbushes/genericbush/hell
	icon = 'voidcrew/icons/obj/flora/hellflora.dmi'
	light_range = 2
	light_power = 2
	resistance_flags = LAVA_PROOF

/obj/structure/flora/ausbushes/genericbush/hell/Initialize()
	icon_state = "genericbush_[rand(1, 4)]"
	light_color = pick("#e87800", "#780606")
	. = ..()

/obj/structure/flora/ausbushes/ywflowers/hell
	icon = 'voidcrew/icons/obj/flora/hellflora.dmi'
	light_color = "#aba507"
	light_power = 3
	light_range = 2
	resistance_flags = LAVA_PROOF

/obj/structure/flora/rock/lava
	icon_state = "basalt"
	desc = "A volcanic rock. Pioneers used to ride these babies for miles."
	icon = 'voidcrew/icons/obj/flora/lavarocks.dmi'

/obj/structure/flora/rock/pile/lava
	icon = 'voidcrew/icons/obj/flora/lavarocks.dmi'
	icon_state = "lavarocks"
	desc = "A pile of rocks."

/obj/structure/flora/tree/dead/hell
	name = "lava tree"
	icon = 'voidcrew/icons/obj/flora/lavatrees.dmi'
	desc = "It's seriously hampering your view of the wastes."
	pixel_x = -16
	light_color = LIGHT_COLOR_BLOOD_MAGIC
	light_range = 2
	light_power = 0.85
	resistance_flags = LAVA_PROOF

//Barren tree default (brown)
/obj/structure/flora/tree/dead/barren
	icon = 'voidcrew/icons/obj/flora/barren_tree.dmi'
	icon_state = "barren_large"
	pixel_x = -16

/obj/structure/flora/tree/dead/barren/Initialize()
	. = ..()
	icon_state = "barren_large"

//Barren tree (purple)
/obj/structure/flora/tree/dead/barren/purple

/obj/structure/flora/tree/dead/barren/purple/Initialize()
	. = ..()
	color = pick( "#846996", "#7b4e99", "#924fab")

//Tall tree (grey)
/obj/structure/flora/tree/dead/tall
	icon = 'voidcrew/icons/obj/flora/tall_trees_dead.dmi'
	icon_state = "tree_1"
	pixel_x = -16
	resistance_flags = LAVA_PROOF

/obj/structure/flora/tree/dead/tall/Initialize()
	. = ..()
	icon_state = "tree_[rand(1, 3)]"
