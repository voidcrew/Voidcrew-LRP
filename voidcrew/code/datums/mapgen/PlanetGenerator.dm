/datum/map_generator/planet_generator
	var/name = "Planet Generator"
	var/mountain_height = 0.85
	var/perlin_zoom = 65

/datum/map_generator/planet_generator/generate_terrain(var/list/turfs)
	. = ..()

	var/planet_heat_level = rand(1, 4)
	// var/strange = pick (prob(85); FALSE, prob(15); TRUE)
	var/datum/planet/planet_type

	var/initial_closed_chance = 45
	var/smoothing_iterations = 20
	var/birth_limit = 4
	var/death_limit = 3

	var/height_seed = rand(0, 50000)
	var/humidity_seed = rand(0, 50000)
	var/heat_seed = rand(0, 50000)

	switch(planet_heat_level)
		if(1)
			planet_type = new /datum/planet/jungle()
		if(2)
			planet_type = new /datum/planet/jungle()
		if(3)
			planet_type = new /datum/planet/jungle()
		if(4)
			planet_type = new /datum/planet/jungle()

	var/string_gen = rustg_cnoise_generate("[initial_closed_chance]", "[smoothing_iterations]", "[birth_limit]", "[death_limit]", "[world.maxx]", "[world.maxy]") //Generate the raw CA data

	for(var/t in turfs)
		var/turf/gen_turf = t
		var/drift_x = (gen_turf.x + rand(-BIOME_RANDOM_SQUARE_DRIFT, BIOME_RANDOM_SQUARE_DRIFT)) / perlin_zoom
		var/drift_y = (gen_turf.y + rand(-BIOME_RANDOM_SQUARE_DRIFT, BIOME_RANDOM_SQUARE_DRIFT)) / perlin_zoom

		var/heat = text2num(rustg_noise_get_at_coordinates("[heat_seed]", "[drift_x]", "[drift_y]"))
		var/height = text2num(rustg_noise_get_at_coordinates("[height_seed]", "[drift_x]", "[drift_y]"))
		var/humidity = text2num(rustg_noise_get_at_coordinates("[humidity_seed]", "[drift_x]", "[drift_y]"))
		var/heat_level
		var/humidity_level
		var/datum/revamped_biome/selected_biome
		var/datum/revamped_biome/cave/selected_cave_biome

		var/area/A = gen_turf.loc
		if(!(A.area_flags & CAVES_ALLOWED))
			continue

		switch(humidity)
			if(0 to 0.25)
				humidity_level = "biome_lowest_humidity"
			if(0.25 to 0.5)
				humidity_level = "biome_low_humidity"
			if(0.5 to 0.75)
				humidity_level = "biome_medium_humidity"
			if(0.75 to 1)
				humidity_level = "biome_high_humidity"
		if(height <= mountain_height)
			switch(heat)
				if(0 to 0.25)
					heat_level = planet_type.coldest_biomes
				if(0.25 to 0.5)
					heat_level = planet_type.cold_biomes
				if(0.5 to 0.75)
					heat_level = planet_type.warm_biomes
				if(0.75 to 1)
					heat_level = planet_type.hot_biomes
			selected_biome = heat_level[humidity_level]
			selected_biome = SSmapping.revamped_biomes[selected_biome]
			selected_biome.generate_overworld(gen_turf)
			CHECK_TICK_HIGH_PRIORITY

		else
			switch(heat)
				if(0 to 0.25)
					heat_level = planet_type.coldest_cave_biomes
				if(0.25 to 0.5)
					heat_level = planet_type.cold_cave_biomes
				if(0.5 to 0.75)
					heat_level = planet_type.warm_cave_biomes
				if(0.75 to 1)
					heat_level = planet_type.hot_cave_biomes
			selected_cave_biome = heat_level[humidity_level]
			selected_cave_biome = SSmapping.revamped_biomes[selected_cave_biome]
			selected_cave_biome.generate_caves(gen_turf, string_gen)

			CHECK_TICK_HIGH_PRIORITY

/turf/open/genturf
	name = "ungenerated turf"
	desc = "If you see this, and you're not a ghost, yell at coders"
	icon = 'icons/turf/debug.dmi'
	icon_state = "genturf"

/area/mine/planetgeneration
	name = "planet generation area"
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	map_generator = /datum/map_generator/jungle_generator
