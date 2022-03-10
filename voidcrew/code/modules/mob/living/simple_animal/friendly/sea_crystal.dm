/mob/living/simple_animal/sea_crystal
	name = "sea crystal"
	desc = "A large, clearly dangerous crystal."
	icon = 'voidcrew/icons/obj/seacrystal.dmi'
	icon_state = "seacrystal"
	icon_dead = "seacrystal"
	maxHealth = 450
	health = 450
	pixel_x = -18
	pixel_y = -10
	faction = list("crystal")
	friendly_verb_continuous = "bumps"
	friendly_verb_simple = "bump"
	speed = 3
	weather_immunities = list("acid", "ash", "lava", "snow")
	pixel_x = -18
	pixel_y = -5

/mob/living/simple_animal/sea_crystal/Initialize()
	. = ..()
	AddSpell(new /obj/effect/proc_holder/spell/voice_of_god(null))
	AddSpell(new /obj/effect/proc_holder/spell/targeted/ethereal_jaunt/crystal(null))
	AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/conjure/crystal_hivelord(null))
