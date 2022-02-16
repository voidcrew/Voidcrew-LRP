/obj/machinery/power/bluespace_miner
	name = "bluespace mining machine"
	desc = "A machine that uses the magic of Bluespace to slowly generate materials and add them to a linked ore silo."
	icon = 'voidcrew/icons/obj/machines/mining_machines.dmi'
	icon_state = "bsminer"
	density = TRUE
	circuit = /obj/item/circuitboard/machine/bluespace_miner
	layer = BELOW_OBJ_LAYER
	use_power = IDLE_POWER_USE
	idle_power_usage = 0
	///Our connection to the ore silo
	var/datum/component/remote_materials/materials
	///List of ores and how much is extracted by default
	var/list/ore_rates = list(/datum/material/iron = 0.3, /datum/material/glass = 0.3, /datum/material/plasma = 0.1,  /datum/material/silver = 0.1, /datum/material/gold = 0.05, /datum/material/titanium = 0.05, /datum/material/uranium = 0.05, /datum/material/diamond = 0.02, /datum/material/bluespace = 0.02)
	/// Multiplier for resources generated you get a free 2x multiplier at t4 laser. Causes power increase with capacitors though
	var/multiplier = 0
	///The power used with t1 parts increases with part upgrade in exchange for more materials
	var/base_power_usage = 12500
	/// Power Multiplier applied whenever a part higher then t1 is added
	var/power_coeff = 1

/obj/machinery/power/bluespace_miner/Initialize(mapload)
	. = ..()
	materials = AddComponent(/datum/component/remote_materials, "bsm", mapload)

/obj/machinery/power/bluespace_miner/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += "<span class='notice'>A small screen on the machine reads, \"Efficiency at [multiplier * 100]%\"</span>"
		. += "<span class='notice'>A small screen on the machine reads, \"Power Usage at [idle_power_usage / 1000]kWs\"</span>"
		if(multiplier >= 5)
			. += "<span class='notice'>Bluespace generation is active.</span>"

/obj/machinery/power/bluespace_miner/RefreshParts()
	multiplier = 1
	for(var/obj/item/stock_parts/micro_laser/laser_tier in component_parts)
		multiplier += (laser_tier.rating-1)/3
	for(var/obj/item/stock_parts/capacitor/capacitor_tier in component_parts)
		power_coeff += (capacitor_tier.rating-1)*0.55
		multiplier += (capacitor_tier.rating-1)*1.3
	idle_power_usage = base_power_usage * power_coeff


/obj/machinery/power/bluespace_miner/Destroy()
	materials = null
	return ..()


/obj/machinery/power/bluespace_miner/examine(mob/user)
	. = ..()
	if(!materials?.silo)
		. += "<span class='notice'>No ore silo connected. Use a multi-tool to link an ore silo to this machine.</span>"
	else if(materials?.on_hold())
		. += "<span class='warning'>Ore silo access is on hold, please contact the quartermaster.</span>"

/obj/machinery/power/bluespace_miner/process()
	update_icon_state()
	if(!materials?.silo || materials?.on_hold())
		return
	var/datum/component/material_container/mat_container = materials.mat_container
	if(!mat_container || panel_open || !powered())
		return
	/// The ore that its going to generate and insert into the Ore Silo
	var/datum/material/ore = pick(ore_rates)
	mat_container.bsm_insert(((ore_rates[ore] * 1000) * multiplier), ore)

/**Used whenever the Bluespace Miner needs to insert its materials into an orm
  * amt -> Amount of resource being deposited
  * datum/material/mat -> The material being deposited
  */
/datum/component/material_container/proc/bsm_insert(amt, datum/material/mat)
	if(!istype(mat))
		mat = SSmaterials.GetMaterialRef(mat)
	if(amt > 0 && has_space(amt))
		if(mat)
			materials[mat] += amt
			total_amount += amt
		else
			/// Amount to input
			for(var/input in materials)
				materials[input] += amt
				total_amount += amt
		return
	return FALSE

/obj/machinery/power/bluespace_miner/update_icon_state()
	if(!powered())
		if(!panel_open)
			icon_state = "bsminer-unpowered"
		else
			icon_state = "bsminer-unpowered-maintenance"
	else
		if(!panel_open)
			icon_state = "bsminer"
		else
			icon_state = "bsminer-maintenance"

/obj/machinery/power/bluespace_miner/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()
	if(default_deconstruction_crowbar(tool, FALSE))
		return TRUE

/obj/machinery/power/bluespace_miner/screwdriver_act(mob/living/user, obj/item/tool)
	. = TRUE
	if(..())
		return
	if(!state_open)
		if(powered())
			if(default_deconstruction_screwdriver(user, "bsminer-maintenance", "bsminer", tool))
				return TRUE
		else if(!powered())
			if(default_deconstruction_screwdriver(user, "bsminer-unpowered-maintenance", "bsminer-unpowered", tool))
				return TRUE
	return FALSE
