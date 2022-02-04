/obj/item/organ/tongue/kepori
	say_mod = "chirps"
	var/static/list/languages_possible_kepi = typecacheof(list(
		/datum/language/common,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/beachbum,
		/datum/language/aphasia,
		/datum/language/piratespeak,
		/datum/language/moffic,
		/datum/language/sylvan,
		/datum/language/shadowtongue,
		/datum/language/terrum,
		/datum/language/teceti_unified
	))

/obj/item/organ/tongue/kepori/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_kepi

/obj/item/organ/tongue/squid
	name = "squid tongue"
	desc = "A smaller tentacle used to synthesize speech."
	icon = 'voidcrew/icons/obj/surgery.dmi'
	icon_state = "tonguesquid"
	var/static/list/languages_possible_squid = typecacheof(list(
		/datum/language/rylethian,
		/datum/language/common,
		/datum/language/xenocommon,
		/datum/language/aphasia,
		/datum/language/narsie,
		/datum/language/monkey,
		/datum/language/shadowtongue,
		/datum/language/ratvar
		))

/obj/item/organ/tongue/squid/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_squid
