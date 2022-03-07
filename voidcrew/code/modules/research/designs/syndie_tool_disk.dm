/datum/design/SyndieWrench
	name = "Suspicious-looking wrench"
	id = "Syndiwrench"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 150)
	build_path = /obj/item/wrench/syndie
	category = list("Imported")

/datum/design/SyndieCrowbar
	name = "Suspicious-looking crowbar"
	id = "SyndiCrowbar"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 50)
	build_path = /obj/item/crowbar/syndie
	category = list("Imported")

/datum/design/SyndieWirecutters
	name = "Suspicious-looking wirecutters"
	id = "SyndiWirecutters"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 80)
	build_path = /obj/item/wirecutters/syndie
	category = list("Imported")

/datum/design/SyndieMultitool
	name = "Suspicious-looking multitool"
	id = "SyndiMultitool"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 50, /datum/material/glass = 20)
	build_path = /obj/item/multitool/syndie
	category = list("Imported")

/datum/design/SyndieScrewdriver
	name = "Screwdriver"
	id = "SyndiScrewdriver"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 75)
	build_path = /obj/item/screwdriver/nuke
	category = list("Imported")

/obj/item/disk/design_disk/adv/syndietools
	name = "Design Disk - Syndicate tools"
	desc = "A design disk containing the pattern for Syndicate tools."
	illustration = "generic"

/obj/item/disk/design_disk/adv/Syndietools/Initialize()
	. = ..()
	blueprints[1] = new /datum/design/SyndieWrench()
	blueprints[2] = new /datum/design/SyndieCrowbar()
	blueprints[3] = new /datum/design/SyndieWirecutters()
	blueprints[4] = new /datum/design/SyndieMultitool()
	blueprints[5] = new /datum/design/SyndieScrewdriver()
