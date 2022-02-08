/datum/ship
	///Ship's name
	var/name
	///Faction this ship is part of
	var/faction = FACTION_NEUTRAL
	///What level is this ship
	var/level = SHIP_WEAK

/datum/ship/neutral
	name = "NEU ship parts"
	faction = FACTION_NEUTRAL

/datum/ship/neutral/medium
	name = "Medium NEU ship parts"
	level = SHIP_MEDIUM

/datum/ship/neutral/high
	name = "High NEU ship parts"
	level = SHIP_STRONG

/datum/ship/nanotrasen
	name = "NT-S ship parts"
	faction = FACTION_NANOTRASEN

/datum/ship/syndicate
	name = "SYN ship parts"
	faction = FACTION_SYNDICATE
