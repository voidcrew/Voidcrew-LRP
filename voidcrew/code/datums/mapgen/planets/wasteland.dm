/datum/planet/wasteland
	biomes = list(
		//NORMAL BIOMES
		"coldest" = list(
			"biome_lowest_humidity" = /datum/biome/ruins,
			"biome_low_humidity" = /datum/biome/wasteland/plains,
			"biome_medium_humidity" = /datum/biome/wasteland,
			"biome_high_humidity" = /datum/biome/wasteland,
			"biome_highest_humidity" = /datum/biome/wasteland/plains
		),
		"cold" = list(
			"biome_lowest_humidity" = /datum/biome/wasteland,
			"biome_low_humidity" = /datum/biome/wasteland,
			"biome_medium_humidity" = /datum/biome/wasteland/forest,
			"biome_high_humidity" = /datum/biome/ruins,
			"biome_highest_humidity" = /datum/biome/wasteland/plains
		),
		"warm" = list(
			"biome_lowest_humidity" = /datum/biome/wasteland,
			"biome_low_humidity" = /datum/biome/wasteland,
			"biome_medium_humidity" = /datum/biome/wasteland/forest,
			"biome_high_humidity" = /datum/biome/wasteland/plains,
			"biome_highest_humidity" = /datum/biome/nuclear
		),
		"perfect" = list(
			"biome_lowest_humidity" = /datum/biome/nuclear,
			"biome_low_humidity" = /datum/biome/wasteland/forest,
			"biome_medium_humidity" = /datum/biome/wasteland/forest,
			"biome_high_humidity" = /datum/biome/wasteland/plains,
			"biome_highest_humidity" = /datum/biome/wasteland
		),
		"hot" = list(
			"biome_lowest_humidity" = /datum/biome/wasteland,
			"biome_low_humidity" = /datum/biome/wasteland/forest,
			"biome_medium_humidity" = /datum/biome/wasteland,
			"biome_high_humidity" = /datum/biome/nuclear,
			"biome_highest_humidity" = /datum/biome/wasteland
		),
		"hottest" = list(
			"biome_lowest_humidity" = /datum/biome/wasteland,
			"biome_low_humidity" = /datum/biome/wasteland/forest,
			"biome_medium_humidity" = /datum/biome/wasteland,
			"biome_high_humidity" = /datum/biome/nuclear,
			"biome_highest_humidity" = /datum/biome/nuclear
		),
		//CAVE BIOMES
		"coldest_cave" = list(
			"biome_lowest_humidity" = /datum/biome/cave/wasteland,
			"biome_low_humidity" = /datum/biome/cave/wasteland,
			"biome_medium_humidity" = /datum/biome/cave/mossy_stone,
			"biome_high_humidity" = /datum/biome/cave/rubble,
			"biome_highest_humidity" = /datum/biome/cave/rubble
		),
		"cold_cave" = list(
			"biome_lowest_humidity" = /datum/biome/cave/wasteland,
			"biome_low_humidity" = /datum/biome/cave/wasteland,
			"biome_medium_humidity" = /datum/biome/cave/rubble,
			"biome_high_humidity" = /datum/biome/cave/rubble,
			"biome_highest_humidity" = /datum/biome/cave/rubble
		),
		"warm_cave" = list(
			"biome_lowest_humidity" = /datum/biome/cave/rubble,
			"biome_low_humidity" = /datum/biome/cave/wasteland,
			"biome_medium_humidity" = /datum/biome/cave/wasteland,
			"biome_high_humidity" = /datum/biome/cave/rubble,
			"biome_highest_humidity" = /datum/biome/cave/mossy_stone
		),
		"hot_cave" = list(
			"biome_lowest_humidity" = /datum/biome/cave/wasteland,
			"biome_low_humidity" = /datum/biome/cave/wasteland,
			"biome_medium_humidity" = /datum/biome/cave/rubble,
			"biome_high_humidity" = /datum/biome/cave/mossy_stone,
			"biome_highest_humidity" = /datum/biome/cave/rubble
		)
	)
