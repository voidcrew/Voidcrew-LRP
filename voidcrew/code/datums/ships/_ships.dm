/datum/ship_parts
	///Ship's name
	var/name
	///Faction this ship is part of
	var/faction = FACTION_NEUTRAL
	///What level is this ship
	var/level = SHIP_WEAK

/datum/ship_parts/neutral
	name = "NEU ship parts"
	faction = FACTION_NEUTRAL

/datum/ship_parts/neutral/medium
	name = "Medium NEU ship parts"
	level = SHIP_MEDIUM

/datum/ship_parts/neutral/high
	name = "High NEU ship parts"
	level = SHIP_STRONG

/datum/ship_parts/nanotrasen
	name = "NT-C ship parts"
	faction = FACTION_NANOTRASEN

/datum/ship_parts/syndicate
	name = "SYN-C ship parts"
	faction = FACTION_SYNDICATE
