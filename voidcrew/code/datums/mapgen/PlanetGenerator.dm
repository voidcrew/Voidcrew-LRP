// #define BIOME_RANDOM_SQUARE_DRIFT 2

/datum/map_generator/planet_generator
	var/name = "Planet Generator"
	var/mountain_height = 0.85
	var/perlin_zoom = 65


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
				// planet_type = /datum/planet/tropical

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
		else //Over mountain_height; It's a mountain
			selected_biome = /datum/biome/mountain
		selected_biome = SSmapping.biomes[selected_biome] //Get the instance of this biome from SSmapping
		selected_biome.generate_turf(gen_turf)
		CHECK_TICK

/turf/open/genturf
	name = "ungenerated turf"
	desc = "If you see this, and you're not a ghost, yell at coders"
	icon = 'icons/turf/debug.dmi'
	icon_state = "genturf"

/area/mine/planetgeneration
	name = "planet generation area"
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	map_generator = /datum/map_generator/jungle_generator
