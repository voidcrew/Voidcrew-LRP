/datum/revamped_biome/grass
	open_turf_types = list(/turf/open/floor/plating/grass/lit = 1)
	flora_spawn_list = list(
		/obj/structure/flora/tree/jungle = 1,
		/obj/structure/flora/ausbushes/brflowers = 1,
		/obj/structure/flora/ausbushes/fernybush = 1,
		/obj/structure/flora/ausbushes/fullgrass = 1,
		/obj/structure/flora/ausbushes/genericbush = 1,
		/obj/structure/flora/ausbushes/grassybush = 1,
		/obj/structure/flora/ausbushes/lavendergrass = 1,
		/obj/structure/flora/ausbushes/lavendergrass = 1,
		/obj/structure/flora/ausbushes/leafybush = 1,
		/obj/structure/flora/ausbushes/palebush = 1,
		/obj/structure/flora/ausbushes/pointybush = 1,
		/obj/structure/flora/ausbushes/ppflowers = 1,
		/obj/structure/flora/ausbushes/reedbush = 1,
		/obj/structure/flora/ausbushes/sparsegrass = 1,
		/obj/structure/flora/ausbushes/stalkybush = 1,
		/obj/structure/flora/ausbushes/stalkybush = 1,
		/obj/structure/flora/ausbushes/sunnybush = 1,
		/obj/structure/flora/ausbushes/ywflowers = 1
	)
	flora_spawn_chance = 25
	mob_spawn_list = list(
		/mob/living/simple_animal/butterfly/beach = 1,
		/mob/living/simple_animal/slime/pet/beach = 1,
		/mob/living/simple_animal/chicken/rabbit/normal/beach = 1,
		/mob/living/simple_animal/chicken/beach = 1,
		/mob/living/simple_animal/chick/beach = 1,
		/mob/living/simple_animal/mouse/beach = 1,
		/mob/living/simple_animal/cow/beach = 1,
		/mob/living/simple_animal/deer/beach = 1
	)
	mob_spawn_chance = 1

/datum/revamped_biome/grass/dense
	flora_spawn_chance = 65
	mob_spawn_list = list(
		/mob/living/simple_animal/pet/cat/cak/beach = 1,
		/mob/living/simple_animal/hostile/retaliate/poison/snake/beach = 1,
		/mob/living/simple_animal/slime/random/beach = 1,
		/mob/living/simple_animal/hostile/poison/bees/beach = 1
	)
	mob_spawn_chance = 1.2

/datum/revamped_biome/beach
	open_turf_types = list(/turf/open/floor/plating/beach/sand/lit = 1)
	mob_spawn_list = list(/mob/living/simple_animal/crab/beach, /mob/living/simple_animal/turtle/beach)
	mob_spawn_chance = 0.6
	flora_spawn_list = list(
		/obj/structure/flora/tree/palm = 1,
		/obj/structure/chair/plastic = 1,
		/obj/item/toy/beach_ball = 1,
		/obj/item/toy/beach_ball/holoball/dodgeball = 1,
		/obj/structure/fluff/beach_umbrella = 1,
		/obj/structure/fluff/beach_umbrella/engine = 1,
		/obj/item/storage/cans/sixbeer = 1,
		/obj/item/clothing/mask/cigarette/rollie/cannabis = 1,
		/obj/item/clothing/under/shorts/purple = 1,
		/obj/item/clothing/under/shorts/red = 1
	)
	flora_spawn_chance = 0.5

/datum/revamped_biome/beach/dense
	open_turf_types = list(/turf/open/floor/plating/beach/sand/lit/dense = 1)
	flora_spawn_list = list(
		/obj/vehicle/ridden/atv/beach = 1,
		/obj/machinery/jukebox/disco/beach = 1,
		/obj/effect/spawner/bundle/costume/mafia/white = 1,
		/obj/machinery/vending/boozeomat/all_access/beach = 1,
		/obj/structure/flora/tree/palm = 1,
		/obj/item/toy/beach_ball = 1,
		/obj/structure/fluff/beach_umbrella = 1
	)
	flora_spawn_chance = 0.6
	mob_spawn_list = list(/mob/living/simple_animal/hostile/jungle/mega_arachnid/beach)
	mob_spawn_chance = 0.05

/datum/revamped_biome/ocean
	open_turf_types = list(/turf/open/water/beach = 1)
	mob_spawn_list = list(/mob/living/simple_animal/beachcarp, /mob/living/simple_animal/hostile/carp/beach)
	mob_spawn_chance = 0.3
	flora_spawn_list = list(
		/obj/structure/flora/rock = 1,
		/obj/structure/flora/rock/pile = 1,
		/obj/vehicle/ridden/lavaboat/dragon = 1
	)
	flora_spawn_chance = 0.6

/datum/revamped_biome/ocean/deep
	open_turf_types = list(/turf/open/water/beach/deep = 1)
	flora_spawn_list = list(/obj/structure/spawner/serpent = 1)
	flora_spawn_chance = 0.1
