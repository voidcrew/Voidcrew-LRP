/datum/controller/subsystem/mapping
	var/list/nt_ship_list
	var/list/syn_ship_list

/datum/controller/subsystem/mapping/Initialize(timeofday)
	if(initialized)
		return
	if(config.defaulted)
		var/old_config = config
		config = global.config.defaultmap
		if(!config || config.defaulted)
			to_chat(world, span_boldannounce("Unable to load next or default map config, defaulting to Meta Station."))
			config = old_config
	initialize_biomes()
	//loadWorld()
	InitializeDefaultZLevels()
	repopulate_sorted_areas()
	process_teleport_locs() //Sets up the wizard teleport locations
	preloadTemplates()



	// Run map generation after ruin generation to prevent issues
	//run_map_generation()
	// Add the transit level
	transit = add_new_zlevel("Transit/Reserved", list(ZTRAIT_RESERVED = TRUE))
	repopulate_sorted_areas()
	// Set up Z-level transitions.
	setup_map_transitions()
	generate_station_area_list()
	initialize_reserved_level(transit.z_value)
	SSticker.OnRoundstart(CALLBACK(src, .proc/spawn_maintenance_loot))
	return ..()
