
//Tropical
/datum/biome/tropical
	turf_type = /turf/open/floor/plating/dirt/jungle/dark
	///Chance of having a structure from the flora types list spawn
	flora_density = 1
	///Chance of having a mob from the fauna types list spawn
	fauna_density = 1
	///list of type paths of objects that can be spawned when the turf spawns flora
	flora_types = list(/obj/structure/flora/grass/jungle)
	///list of type paths of mobs that can be spawned when the turf spawns fauna
	fauna_types = list(/mob/living/simple_animal/butterfly)

/datum/biome/tropical/jungle
/datum/biome/tropical/jungle/sparse
/datum/biome/tropical/jungle/mud
/datum/biome/tropical/jungle/dense
/datum/biome/tropical/beach
	turf_type = /turf/open/floor/plating/dirt/jungle/dark
/datum/biome/tropical/beach/dense
	turf_type = /turf/open/floor/plating/dirt/jungle/dark
/datum/biome/tropical/ocean
	turf_type = /turf/open/water
/datum/biome/tropical/ocean/deep
	turf_type = /turf/open/water
/datum/biome/tropical/beach/shore
