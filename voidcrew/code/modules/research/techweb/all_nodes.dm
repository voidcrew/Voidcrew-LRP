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
