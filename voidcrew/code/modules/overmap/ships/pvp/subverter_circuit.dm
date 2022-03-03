/obj/item/circuitboard/machine/subverter
	name = "Interdictor (Machine Board)"
	icon_state = "engineering"
	build_path = /obj/machinery/subverter
	custom_materials = list(/datum/material/glass = 1000, /datum/material/bluespace = 8000)
	req_components = list(
		/obj/item/stock_parts/scanning_module = 1,
		/obj/item/stock_parts/micro_laser = 2, //engine_cooldown
		/obj/item/stock_parts/manipulator = 2, //recharge_time
		/obj/item/stock_parts/capacitor = 1) //power efficiency, how much heat is produced etc

/datum/design/board/shuttle/subverter
	name = "Machine Design (Interdictor)"
	desc = "The circuit board for an interdictor."
	id = "shuttle_subverter"
	materials = list(/datum/material/glass = 1000, /datum/material/bluespace = 8000)
	build_path = /obj/item/circuitboard/machine/subverter
	category = list("Shuttle Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING

/datum/techweb_node/subverter
	id = "subverter"
	display_name = "Space Hacking"
	description = "Construct interdictors that can remotely pull vessels out of hyperspace."
	prereq_ids = list("datatheory")
	design_ids = list("shuttle_subverter")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1500)
	export_price = 5000
