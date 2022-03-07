/obj/structure/closet/crate/necropolis/dragon/beach
	name = "sea crystal chest"
	desc = "A glowing chest that fell out of the mighty sea crystal."
	icon_state = "wooden"
	icon = 'goon/icons/obj/crates.dmi'
	open_sound = 'sound/machines/wooden_closet_open.ogg'
	close_sound = 'sound/machines/wooden_closet_close.ogg'
	open_sound_volume = 25
	close_sound_volume = 50
	color = "#00bfff"
	light_color = "#00bfff"
	light_range = 3
	light_power = 3

/obj/structure/spawner/seacrystal
	name = "sea crystal"
	desc = "A large cystal. Terrible monsters are pouring out from all around it."
	icon = 'voidcrew/icons/obj/seacrystal.dmi'
	icon_state = "seacrystal"
	faction = list("beach")
	max_mobs = 1
	spawn_time = 250
	max_integrity = 500
	pixel_x = -18
	pixel_y = -5
	mob_types = list(/mob/living/simple_animal/hostile/carp/megacarp/beach)
	move_resist = INFINITY
	anchored = TRUE
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	layer = FLY_LAYER
	light_color = LIGHT_COLOR_ELECTRIC_GREEN
	light_power = 1
	light_range = 4

/obj/structure/spawner/seacrystal/Initialize()
	. = ..()
	for(var/F in RANGE_TURFS(1, src))
		if(ismineralturf(F))
			var/turf/closed/mineral/M = F
			M.ScrapeAway(null, CHANGETURF_IGNORE_AIR)
	AddComponent(/datum/component/seacrystal)

/obj/structure/spawner/seacrystal/deconstruct(disassembled)
	new /obj/effect/temp_visual/seacrystal/sparks(loc)
	new /obj/structure/closet/crate/necropolis/dragon/beach(loc)
	return ..()
