/datum/ship_parts
	///Ship's name
	var/name
	///Faction this ship is part of
	var/faction = FACTION_NEUTRAL
	///What level is this ship
	var/level = SHIP_WEAK
	var/obj/item/ship_parts/part_type

/datum/ship_parts/neutral
	name = "NEU ship parts"
	faction = FACTION_NEUTRAL
	part_type = /obj/item/ship_parts/neutral

/datum/ship_parts/neutral/medium
	name = "Medium NEU ship parts"
	level = SHIP_MEDIUM
	part_type = /obj/item/ship_parts/neutral/medium

/datum/ship_parts/neutral/high
	name = "High NEU ship parts"
	level = SHIP_STRONG
	part_type = /obj/item/ship_parts/neutral/high

/datum/ship_parts/nanotrasen
	name = "NT-C ship parts"
	faction = FACTION_NANOTRASEN
	part_type = /obj/item/ship_parts/nanotrasen

/datum/ship_parts/syndicate
	name = "SYN-C ship parts"
	faction = FACTION_SYNDICATE
	part_type = /obj/item/ship_parts/syndicate
