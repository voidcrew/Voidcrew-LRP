// #define BIOME_RANDOM_SQUARE_DRIFT 2

/datum/map_generator/planet_generator
	var/name = "Planet Generator"
	var/mountain_height = 0.85
	var/perlin_zoom = 65

	///Weighted list of the types that spawns if the turf is open
	var/open_turf_types = list(/turf/open/floor/plating/asteroid = 1)
	///Weighted list of the types that spawns if the turf is closed
	var/closed_turf_types =  list(/turf/closed/mineral/random/volcanic = 1)


	///Weighted list of extra features that can spawn in the area, such as geysers.
	var/list/feature_spawn_list = list(/obj/structure/geyser/random = 1)
	///Weighted list of mobs that can spawn in the area.
	var/list/mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/goliath/beast/random = 50, /obj/structure/spawner/lavaland/goliath = 3, \
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/random = 40, /obj/structure/spawner/lavaland = 2, \
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 30, /obj/structure/spawner/lavaland/legion = 3, \
		SPAWN_MEGAFAUNA = 4, /mob/living/simple_animal/hostile/asteroid/goldgrub = 10)
	///Weighted list of flora that can spawn in the area.
	var/list/flora_spawn_list = list(/obj/structure/flora/ash/leaf_shroom = 2 , /obj/structure/flora/ash/cap_shroom = 2 , /obj/structure/flora/ash/stem_shroom = 2 , /obj/structure/flora/ash/cacti = 1, /obj/structure/flora/ash/tall_shroom = 2)
	// Weighted list of Megafauna that can spawn in the caves
	// var/list/megafauna_spawn_list


	///Base chance of spawning a mob
	var/mob_spawn_chance = 6
	///Base chance of spawning flora
	var/flora_spawn_chance = 2
	///Base chance of spawning features
	var/feature_spawn_chance = 0.1
	///Unique ID for this spawner
	var/string_gen

	///Chance of cells starting closed
	var/initial_closed_chance = 45
	///Amount of smoothing iterations
	var/smoothing_iterations = 20
	///How much neighbours does a dead cell need to become alive
	var/birth_limit = 4
	///How little neighbours does a alive cell need to die
	var/death_limit = 3


/datum/map_generator/planet_generator/generate_terrain(var/list/turfs)
	. = ..()
	var/planet_heat_level = rand(1, 4)
	var/strange = FALSE
	var/height_seed = rand(0, 50000)
	var/humidity_seed = rand(0, 50000)
	var/heat_seed = rand(0, 50000)
	var/datum/planet/planet_type

	strange = pick (prob(85); FALSE, prob(15); TRUE)

	switch(planet_heat_level)
		if(1)
			if (!strange)
				planet_type = new /datum/planet/tropical() // placeholder
			else
				planet_type = new /datum/planet/tropical() // placeholder strange
		if(2)
			if (!strange)
				planet_type = new /datum/planet/tropical() // placeholder
			else
				planet_type = new /datum/planet/tropical() // placeholder strange
		if(3)
			if (!strange)
				planet_type = new /datum/planet/tropical() // placeholder
			else
				planet_type = new /datum/planet/tropical() // placeholder strange
		if(4)
			if (!strange)
				planet_type = new /datum/planet/tropical() // placeholder
			else
				planet_type = new /datum/planet/tropical() // placeholder strange

	var/start_time = REALTIMEOFDAY
	string_gen = rustg_cnoise_generate("[initial_closed_chance]", "[smoothing_iterations]", "[birth_limit]", "[death_limit]", "[world.maxx]", "[world.maxy]") //Generate the raw CA data

	for(var/t in turfs) //Go through all the turfs and generate them
		var/turf/gen_turf = t
		var/drift_x = (gen_turf.x + rand(-2, 2)) / perlin_zoom
		var/drift_y = (gen_turf.y + rand(-2, 2)) / perlin_zoom

		var/height = text2num(rustg_noise_get_at_coordinates("[height_seed]", "[drift_x]", "[drift_y]"))

		var/area/A = gen_turf.loc //meet my friends, Ctrl+C and Ctrl+V!
		if(!(A.area_flags & CAVES_ALLOWED))
			continue

		var/datum/biome/selected_biome
		if(height <= 0.85) //If height is less than 0.85, we generate biomes based on the heat and humidity of the area.
			var/humidity = text2num(rustg_noise_get_at_coordinates("[humidity_seed]", "[drift_x]", "[drift_y]"))
			var/heat = text2num(rustg_noise_get_at_coordinates("[heat_seed]", "[drift_x]", "[drift_y]"))
			var/heat_level //Type of heat zone we're in LOW-MEDIUM-HIGH
			var/humidity_level  //Type of humidity zone we're in LOW-MEDIUM-HIGH

			switch(heat)
				if(0 to 0.25)
					heat_level = planet_type.coldest_biomes
				if(0.25 to 0.5)
					heat_level = planet_type.cold_biomes
				if(0.5 to 0.75)
					heat_level = planet_type.warm_biomes
				if(0.75 to 1)
					heat_level = planet_type.hot_biomes

			switch(humidity)
				if(0 to 0.25)
					humidity_level = "biome_lowest_humidity"
				if(0.25 to 0.5)
					humidity_level = "biome_low_humidity"
				if(0.5 to 0.75)
					humidity_level = "biome_medium_humidity"
				if(0.75 to 1)
					humidity_level = "biome_high_humidity"
			selected_biome = heat_level[humidity_level]
			selected_biome = SSmapping.biomes[selected_biome] //Get the instance of this biome from SSmapping
			selected_biome.generate_turf(gen_turf)
			CHECK_TICK
		else //Over mountain_height; It's a mountain
			// selected_biome = /datum/biome/mountain
			var/closed = text2num(string_gen[world.maxx * (gen_turf.y - 1) + gen_turf.x])
			var/stored_flags
			if(gen_turf.flags_1 & NO_RUINS_1)
				stored_flags |= NO_RUINS_1
			var/turf/new_turf = pickweight(closed ? closed_turf_types : open_turf_types)
			new_turf = gen_turf.ChangeTurf(new_turf, initial(new_turf.baseturfs), CHANGETURF_DEFER_CHANGE)
			new_turf.flags_1 |= stored_flags



/turf/open/genturf
	name = "ungenerated turf"
	desc = "If you see this, and you're not a ghost, yell at coders"
	icon = 'icons/turf/debug.dmi'
	icon_state = "genturf"

/area/mine/planetgeneration
	name = "planet generation area"
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	map_generator = /datum/map_generator/jungle_generator
