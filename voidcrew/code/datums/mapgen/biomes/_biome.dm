/datum/biome/grass
	turf_type = /turf/open/floor/plating/grass/lit
	flora_types = list(
		/obj/structure/flora/tree/jungle,
		/obj/structure/flora/ausbushes/brflowers,
		/obj/structure/flora/ausbushes/fernybush,
		/obj/structure/flora/ausbushes/fullgrass,
		/obj/structure/flora/ausbushes/genericbush,
		/obj/structure/flora/ausbushes/grassybush,
		/obj/structure/flora/ausbushes/lavendergrass,
		/obj/structure/flora/ausbushes/lavendergrass,
		/obj/structure/flora/ausbushes/leafybush,
		/obj/structure/flora/ausbushes/palebush,
		/obj/structure/flora/ausbushes/pointybush,
		/obj/structure/flora/ausbushes/ppflowers,
		/obj/structure/flora/ausbushes/reedbush,
		/obj/structure/flora/ausbushes/sparsegrass,
		/obj/structure/flora/ausbushes/stalkybush,
		/obj/structure/flora/ausbushes/stalkybush,
		/obj/structure/flora/ausbushes/sunnybush,
		/obj/structure/flora/ausbushes/ywflowers
	)
	flora_density = 25
	fauna_types = list(
		/mob/living/simple_animal/butterfly/beach,
		/mob/living/simple_animal/slime/pet/beach,
		/mob/living/simple_animal/chicken/rabbit/normal/beach,
		/mob/living/simple_animal/chicken/beach,
		/mob/living/simple_animal/chick/beach,
		/mob/living/simple_animal/mouse/beach,
		/mob/living/simple_animal/cow/beach,
		/mob/living/simple_animal/deer/beach
	)
	fauna_density = 1

/datum/biome/grass/dense
	flora_density = 65
	fauna_types = list(
		/mob/living/simple_animal/pet/cat/cak/beach,
		/mob/living/simple_animal/hostile/retaliate/poison/snake/beach,
		/mob/living/simple_animal/slime/random/beach,
		/mob/living/simple_animal/hostile/poison/bees/beach
	)
	fauna_density = 1.2

/datum/biome/beach
	turf_type = /turf/open/floor/plating/beach/sand/lit
	fauna_types = list(/mob/living/simple_animal/crab/beach, /mob/living/simple_animal/turtle/beach)
	fauna_density = 0.6
	flora_types = list(
		/obj/structure/flora/tree/palm,
		/obj/structure/chair/plastic,
		/obj/item/toy/beach_ball,
		/obj/item/toy/beach_ball/holoball/dodgeball,
		/obj/structure/fluff/beach_umbrella,
		/obj/structure/fluff/beach_umbrella/engine,
		/obj/item/storage/cans/sixbeer,
		/obj/item/clothing/mask/cigarette/rollie/cannabis,
		/obj/item/clothing/under/shorts/purple,
		/obj/item/clothing/under/shorts/red
	)
	flora_density = 0.5

/datum/biome/beach/dense
	turf_type = /turf/open/floor/plating/beach/sand/lit/dense
	flora_types = list(
		/obj/vehicle/ridden/atv/beach,
		/obj/machinery/jukebox/disco/beach,
		/obj/effect/spawner/bundle/costume/mafia/white,
		/obj/machinery/vending/boozeomat/all_access/beach,
		/obj/structure/flora/tree/palm,
		/obj/item/toy/beach_ball,
		/obj/structure/fluff/beach_umbrella
	)
	flora_density = 0.6
	fauna_types = list(/mob/living/simple_animal/hostile/jungle/mega_arachnid/beach)
	fauna_density = 0.1

/datum/biome/ocean
	turf_type = /turf/open/water/beach
	fauna_types = list(/mob/living/simple_animal/beachcarp, /mob/living/simple_animal/hostile/carp/beach)
	fauna_density = 0.5
	flora_types = list(
		/obj/structure/flora/rock,
		/obj/structure/flora/rock/pile,
		/obj/vehicle/ridden/lavaboat/dragon
	)
	flora_density = 0.6

/datum/biome/ocean/deep
	turf_type = /turf/open/water/beach/deep
	flora_types = list(/obj/structure/spawner/serpent)
	flora_density = 0.1
