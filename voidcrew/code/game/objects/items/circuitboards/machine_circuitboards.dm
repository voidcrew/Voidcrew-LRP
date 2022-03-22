/**
 # PACMANS
 */
/obj/item/circuitboard/machine/pacman/uranium
	name = "SUPERPACMAN-type Generator (Machine Board)"
	icon_state = "engineering"
	build_path = /obj/machinery/power/port_gen/pacman/uranium

/obj/item/circuitboard/machine/pacman/diamond
	name = "MRSPACMAN-type Generator (Machine Board)"
	build_path = /obj/machinery/power/port_gen/pacman/diamond

/**
 * # CLONING
 */
/obj/item/circuitboard/machine/clonepod
	name = "Clone Pod (Machine Board)"
	icon_state = "medical"
	build_path = /obj/machinery/clonepod
	req_components = list(
		/obj/item/stack/cable_coil = 2,
		/obj/item/stock_parts/scanning_module = 2,
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stack/sheet/glass = 1)

/obj/item/circuitboard/machine/clonepod/experimental
	name = "Experimental Clone Pod (Machine Board)"
	icon_state = "medical"
	build_path = /obj/machinery/clonepod/experimental

/obj/item/circuitboard/machine/clonescanner
	name = "Cloning Scanner (Machine Board)"
	icon_state = "medical"
	build_path = /obj/machinery/dna_scannernew
	req_components = list(
		/obj/item/stock_parts/scanning_module = 1,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/cable_coil = 2)

/**
 * # NANITES
 */
/obj/item/circuitboard/machine/nanite_chamber
	name = "Nanite Chamber (Machine Board)"
	icon_state = "science"
	build_path = /obj/machinery/nanite_chamber
	req_components = list(
		/obj/item/stock_parts/scanning_module = 2,
		/obj/item/stock_parts/micro_laser = 2,
		/obj/item/stock_parts/manipulator = 1)

/obj/item/circuitboard/machine/nanite_program_hub
	name = "Nanite Program Hub (Machine Board)"
	icon_state = "science"
	build_path = /obj/machinery/nanite_program_hub
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 1)

/obj/item/circuitboard/machine/nanite_programmer
	name = "Nanite Programmer (Machine Board)"
	icon_state = "science"
	build_path = /obj/machinery/nanite_programmer
	req_components = list(
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/micro_laser = 2,
		/obj/item/stock_parts/scanning_module = 1)

/obj/item/circuitboard/machine/public_nanite_chamber
	name = "Public Nanite Chamber (Machine Board)"
	icon_state = "science"
	build_path = /obj/machinery/public_nanite_chamber
	req_components = list(
		/obj/item/stock_parts/micro_laser = 2,
		/obj/item/stock_parts/manipulator = 1,
	)
	///The cloud ID this nanite chamber will be synced to upon being built.
	var/cloud_id = 1

/obj/item/circuitboard/machine/public_nanite_chamber/multitool_act(mob/living/user)
	. = ..()
	var/new_cloud = input("Set the public nanite chamber's Cloud ID (1-100).", "Cloud ID", cloud_id) as num|null // TODO - TGUI this after rebase
	if(!new_cloud || (loc != user))
		to_chat(user, "<span class='warning'>You must hold the circuitboard to change its Cloud ID!</span>")
		return
	cloud_id = clamp(round(new_cloud, 1), 1, 100)

/obj/item/circuitboard/machine/public_nanite_chamber/examine(mob/user)
	. = ..()
	. += "Cloud ID is currently set to [cloud_id]."

/obj/item/circuitboard/machine/autodoc
	name = "Autodoc (Machine Board)"
	build_path = /obj/machinery/autodoc
	req_components = list(/obj/item/scalpel/advanced = 1,
		/obj/item/retractor/advanced = 1,
		/obj/item/surgicaldrill/advanced = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stock_parts/micro_laser = 3,
		/obj/item/stock_parts/matter_bin = 1)

/obj/item/circuitboard/machine/bluespace_miner
	name = "Bluespace Miner (Machine Board)"
	build_path = /obj/machinery/power/bluespace_miner
	req_components = list(
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/capacitor = 3,
		/obj/item/bluespace_parts/miningcore_filled = 1)
	needs_anchored = TRUE

/obj/item/circuitboard/machine/shuttle/engine/plasma
	name = "Plasma Thruster (Machine Board)"
	build_path = /obj/machinery/power/shuttle/engine/fueled/plasma
	req_components = list(/obj/item/stock_parts/capacitor = 2,
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/micro_laser = 1)

/obj/item/circuitboard/machine/shuttle/engine/electric
	name = "Ion Thruster (Machine Board)"
	build_path = /obj/machinery/power/shuttle/engine/electric
	req_components = list(/obj/item/stock_parts/capacitor = 3,
		/obj/item/stock_parts/micro_laser = 3)

/obj/item/circuitboard/machine/shuttle/engine/expulsion
	name = "Expulsion Thruster (Machine Board)"
	build_path = /obj/machinery/power/shuttle/engine/fueled/expulsion
	req_components = list(/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/matter_bin = 2)

/obj/item/circuitboard/machine/shuttle/engine/oil
	name = "Oil Thruster (Machine Board)"
	build_path = /obj/machinery/power/shuttle/engine/liquid/oil
	req_components = list(/obj/item/reagent_containers/glass/beaker = 4,
		/obj/item/stock_parts/micro_laser = 2)

/obj/item/circuitboard/machine/shuttle/engine/void
	name = "Void Thruster (Machine Board)"
	build_path = /obj/machinery/power/shuttle/engine/void
	req_components = list(/obj/item/stock_parts/capacitor/quadratic = 2,
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/micro_laser/quadultra = 1)

/obj/item/circuitboard/machine/shuttle/heater
	name = "Fueled Engine Heater (Machine Board)"
	build_path = /obj/machinery/atmospherics/components/unary/shuttle/heater
	req_components = list(/obj/item/stock_parts/micro_laser = 2,
		/obj/item/stock_parts/matter_bin = 1)

/obj/item/circuitboard/machine/shuttle/smes
	name = "Electric Engine Precharger (Machine Board)"
	build_path = /obj/machinery/power/smes/shuttle
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/cell = 3,
		/obj/item/stock_parts/capacitor = 1
	)

/obj/item/circuitboard/machine/cassette/adv_cassette_deck
	name = "Advanced Cassette Deck (Machine Board)"
	build_path = /obj/machinery/cassette/adv_cassette_deck
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/stock_parts/cell = 1,
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stack/sheet/glass = 1
	)
