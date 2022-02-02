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
