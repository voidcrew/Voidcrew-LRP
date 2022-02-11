/datum/controller/subsystem/mapping/preloadTemplates(path = "_maps/templates/") //see master controller setup
	. = ..()
	load_ship_templates()

#define CHECK_STRING_EXISTS(X) if(!istext(data[X])) { log_world("[##X] missing from json!"); continue; }
#define CHECK_LIST_EXISTS(X) if(!islist(data[X])) { log_world("[##X] missing from json!"); continue; }

/datum/controller/subsystem/mapping/proc/load_ship_templates()
	maplist = list()
	ship_purchase_list = list()
	var/list/filelist = flist("_maps/configs/")
	for(var/filename in filelist)
		var/file = file("_maps/configs/" + filename)
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
		CHECK_STRING_EXISTS("map_path")
		CHECK_LIST_EXISTS("job_slots")
		var/datum/map_template/shuttle/purchasing_shuttles = new(data["map_path"], data["map_name"], TRUE)
		purchasing_shuttles.file_name = data["map_path"]
		purchasing_shuttles.category = "shiptest"

		if(istext(data["map_short_name"]))
			purchasing_shuttles.short_name = data["map_short_name"]
		else
			purchasing_shuttles.short_name = copytext(purchasing_shuttles.name, 1, 20)
		if(istext(data["prefix"]))
			purchasing_shuttles.prefix = data["prefix"]
		if(islist(data["namelists"]))
			purchasing_shuttles.name_categories = data["namelists"]

		purchasing_shuttles.job_slots = list()
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
					stack_trace("Invalid job outfit! [value["outfit"]] on [purchasing_shuttles.name]'s config! Defaulting to assistant clothing.")
					job_outfit = /datum/outfit/job/assistant
				job_slot = new /datum/job(job, job_outfit)
				job_slot.wiki_page = value["wiki_page"]
				job_slot.exp_requirements = value["exp_requirements"]
				job_slot.officer = value["officer"]
				slots = value["slots"]

			if(!job_slot || !slots)
				stack_trace("Invalid job slot entry! [job]: [value] on [purchasing_shuttles.name]'s config! Excluding job.")
				continue

			purchasing_shuttles.job_slots[job_slot] = slots
		if(isnum(data["parts_needed"]))
			purchasing_shuttles.parts_needed = data["parts_needed"]
			if(purchasing_shuttles.prefix == FACTION_NEUTRAL) // Assign Neutral's ship strengths
				switch(purchasing_shuttles.parts_needed)
					if(1)
						purchasing_shuttles.ship_level = SHIP_WEAK
					if(2)
						purchasing_shuttles.ship_level = SHIP_MEDIUM
					if(3, INFINITY)
						purchasing_shuttles.ship_level = SHIP_STRONG
			ship_purchase_list["[purchasing_shuttles.prefix] [purchasing_shuttles.name] \
				([purchasing_shuttles.parts_needed] [purchasing_shuttles.prefix == FACTION_NEUTRAL ? "[purchasing_shuttles.ship_level] " : ""][purchasing_shuttles.prefix] parts)"] = purchasing_shuttles // VOIDCREW
		if(isnum(data["limit"]))
			purchasing_shuttles.limit = data["limit"]
		shuttle_templates[purchasing_shuttles.file_name] = purchasing_shuttles
		map_templates[purchasing_shuttles.file_name] = purchasing_shuttles
		if(isnum(data["roundstart"]) && data["roundstart"])
			maplist[purchasing_shuttles.name] = purchasing_shuttles

#undef CHECK_STRING_EXISTS
#undef CHECK_LIST_EXISTS
