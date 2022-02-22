/obj/item/disk/antivirus
	name = "I.A.N. antivirus disk"
	desc = "A disk containing a single antiviral node, good for preventing one ship subversion. Load into helm."
	random_color = FALSE
	color = "#FFFF00"
	custom_materials = list(/datum/material/iron = 300, /datum/material/glass = 100)

/datum/supply_pack/security/antivirus_crate
	name = "Antivirus Crate"
	desc = "Contains an antiviral node disk, good for preventing a single subversion!."
	cost = 4500
	contains = list(
		/obj/item/disk/antivirus
	)
	crate_name = "Antivirus Crate"
