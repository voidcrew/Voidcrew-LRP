// Hey! Listen! Update \config\iceruinblacklist.txt with your new ruins!

/datum/map_template/ruin/icemoon
	prefix = "_maps/RandomRuins/IceRuins/"
	allow_duplicates = FALSE
	cost = 5

// above ground only

/datum/map_template/ruin/icemoon/engioutpost
	name = "Engineer Outpost"
	id = "engioutpost"
	description = "Blown up by an unfortunate accident."
	suffix = "icemoon_surface_engioutpost.dmm"

/datum/map_template/ruin/icemoon/slimerancher //Shiptest edit
	name = "Slime Ranch"
	id = "slimerancher"
	description = "Slime ranchin with the bud."
	suffix = "icemoon_surface_slimerancher.dmm"

/datum/map_template/ruin/icemoon/kitchen //Voidcrew edit
	name = "Ruined kitchen"
	id = "icekitchen"
	description = "Something terrible happened with the local fauna"
	suffix = "icemoon_surface_kitchen.dmm"

/datum/map_template/ruin/icemoon/icemoon_surface_russian_outpost //Voidcrew edit
	name = "Russian Outpost"
	id = "icemoon_surface_russian_outpost"
	description = "The russians have set a research outpost around some unknown object..."
	suffix = "icemoon_surface_russian_outpost.dmm"

/datum/map_template/ruin/icemoon/imperialchurch //Voidcrew edit
	id = "imperialchurch"
	suffix = "imperialchurch.dmm"
	name = "Forgotten Church"
	description = "Formerly a place of worship that served a few religious groups over the years, now lays abandoned with msot of the items left behind including the guardians that protect this place."

// above and below ground together


// below ground only

/datum/map_template/ruin/icemoon
	name = "underground ruin"

/datum/map_template/ruin/icemoon/abandonedvillage
	name = "Abandoned Village"
	id = "abandonedvillage"
	description = "Who knows what lies within?"
	suffix = "icemoon_underground_abandoned_village.dmm"

/datum/map_template/ruin/icemoon/hermit
	name = "Frozen Shack"
	id = "hermitshack"
	description = "A place of shelter for a lone hermit, scraping by to live another day."
	suffix = "icemoon_underground_hermit.dmm"

/datum/map_template/ruin/icemoon/wendigo_cave
	name = "Wendigo Cave"
	id = "wendigocave"
	description = "Into the jaws of the beast."
	suffix = "icemoon_underground_wendigo_cave.dmm"

/datum/map_template/ruin/icemoon/corpreject
	name = "NT Security Solutions Site Gamma"
	id = "corpreject"
	description = "Nanotrasen Corporate Security Solutions vault site Gamma."
	suffix = "icemoon_surface_corporate_rejects.dmm"
