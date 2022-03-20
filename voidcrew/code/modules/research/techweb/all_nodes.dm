////////////////////// IPC Parts ///////////////////////
/datum/techweb_node/ipc_organs
	id = "ipc_organs"
	display_name = "IPC Parts"
	description = "We have the technology to replace him."
	prereq_ids = list("cyber_organs","robotics")
	design_ids = list("robotic_liver", "robotic_eyes", "robotic_tongue", "robotic_stomach", "robotic_ears", "power_cord")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1500)
	export_price = 5000

/datum/techweb_node/id_permits
	id = "id_permits"
	display_name = "Cyberware Access Permit"
	description = "A chip to uprgade an ID with bot access. Now in printable format."
	prereq_ids = list("datatheory")
	design_ids = list("robo_access_card")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 500)
	export_price = 1000

/datum/techweb_node/exp_surgery/New()
	design_ids |= list("autodoc")

/datum/techweb_node/bs_mining
	id = "bluespace_mining"
	display_name = "Bluespace Mining Technology"
	description = "Harness the power of bluespace to make materials out of nothing. Slowly."
	prereq_ids = list("bluespace_storage", "adv_mining")
	design_ids = list("bluespace_miner", "miningcore_shell")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 7500)

/////////////////////////shuttle tech/////////////////////////
/datum/techweb_node/basic_shuttle_tech
	id = "basic_shuttle"
	display_name = "Basic Shuttle Research"
	description = "Research the technology required to create and use basic shuttles."
	prereq_ids = list("bluespace_travel", "adv_engi")
	design_ids = list("engine_plasma", "engine_ion", "engine_heater", "engine_smes", "shuttle_helm", "shuttle_autopilot") //, "rapid_shuttle_designator")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 10000)
	export_price = 5000

/datum/techweb_node/exp_shuttle_tech
	id = "exp_shuttle"
	display_name = "Experimental Shuttle Research"
	description = "A bunch of engines and related shuttle parts that are likely not really that useful, but could be in strange situations."
	prereq_ids = list("basic_shuttle")
	design_ids = list("engine_expulsion")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
	export_price = 2500

/datum/techweb_node/cassette_tech
	id = "cassette_tech"
	display_name = "Cassette Technology Reseach"
	description = "Cassette technology recovered from old walkmans and cassettes."
	prereq_ids = list("comptech")
	design_ids = list("adv_cassette_deck","cassette","cassette_deck")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
