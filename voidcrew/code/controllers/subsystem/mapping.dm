/datum/controller/subsystem/mapping
	var/list/nt_ship_list
	var/list/syn_ship_list
	var/list/maplist
	var/list/ship_purchase_list

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

	load_ship_templates()

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

#define CHECK_STRING_EXISTS(X) if(!istext(data[X])) { log_world("[##X] missing from json!"); continue; }
#define CHECK_LIST_EXISTS(X) if(!islist(data[X])) { log_world("[##X] missing from json!"); continue; }
/datum/controller/subsystem/mapping/proc/load_ship_templates()
	maplist = list()
	nt_ship_list = list()
	syn_ship_list = list()
	ship_purchase_list = list()
	var/list/filelist = flist("voidcrew/_maps/config/")
	for(var/filename in filelist)
		var/file = file("voidcrew/_maps/config/" + filename)
		if(!file)
			log_world("Could not open map config: [filename]")
			continue
		file = file2text(file)
		if(!file)
			log_world("map config is not text: [filename]")
			continue

		var/list/data = json_decode(file)
		if(!data)
			log_world("map config is not json: [filename]")
			continue

		CHECK_STRING_EXISTS("map_name")
		CHECK_STRING_EXISTS("map_id")
		CHECK_LIST_EXISTS("job_slots")
		var/datum/map_template/shuttle/shuttle = new(data["map_path"], data["map_name"], TRUE)
		shuttle.suffix = data["map_id"]
		shuttle.port_id = "voidcrew"
		shuttle.shuttle_id = data["map_id"]

		if(istext(data["map_short_name"]))
			shuttle.short_name = data["map_short_name"]
		else
			shuttle.short_name = copytext(shuttle.name, 1, 20)
		if(istext(data["prefix"]))
			shuttle.faction_prefix = data["prefix"]
		if(islist(data["namelists"]))
			shuttle.name_categories = data["namelists"]

		if(istext(data["antag_datum"]))
			var/path = "/datum/antagonist/" + data["antag_datum"]
			shuttle.antag_datum = text2path(path)

		shuttle.job_slots = list()
		var/list/job_slot_list = data["job_slots"]
		for(var/job in job_slot_list)
			var/datum/job/job_slot
			var/value = job_slot_list[job]
			var/slots
			if(isnum(value))
				job_slot = SSjob.GetJob(job)
				slots = value
			else if(islist(value))
				var/datum/outfit/job_outfit = text2path(value["outfit"])
				if(isnull(job_outfit))
					stack_trace("Invalid job outfit! [value["outfit"]] on [shuttle.name]'s config! Defaulting to assistant clothing.")
					job_outfit = /datum/outfit/job/assistant
				job_slot = new /datum/job(job, job_outfit)
				//job_slot.wiki_page = value["wiki_page"]
				job_slot.exp_requirements = value["exp_requirements"]
				//job_slot.officer = value["officer"]
				slots = value["slots"]

			if(!job_slot || !slots)
				stack_trace("Invalid job slot entry! [job]: [value] on [shuttle.name]'s config! Excluding job.")
				continue

			shuttle.job_slots[job_slot] = slots

		shuttle.disable_passwords = data["disable_passwords"] ? TRUE : FALSE
		if(isnum(data["cost"]))
			shuttle.cost = data["cost"]
			//ship_purchase_list["[shuttle.faction_prefix] [shuttle.name] ([shuttle.cost] [CONFIG_GET(string/metacurrency_name)]s)"] = shuttle // VOIDCREW
		if(isnum(data["limit"]))
			shuttle.limit = data["limit"]
		shuttle_templates[shuttle.shuttle_id] = shuttle
		map_templates[shuttle.shuttle_id] = shuttle
		if(isnum(data["roundstart"]) && data["roundstart"])
			maplist[shuttle.name] = shuttle
		switch(shuttle.faction_prefix)
			if("NT-C")
				nt_ship_list[shuttle.name] = shuttle
			if("SYN-C")
				syn_ship_list[shuttle.name] = shuttle
#undef CHECK_STRING_EXISTS
#undef CHECK_LIST_EXISTS
