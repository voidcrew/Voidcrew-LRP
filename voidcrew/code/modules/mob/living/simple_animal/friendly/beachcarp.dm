/mob/living/simple_animal/beachcarp
	name = "void carp"
	desc = "A not-so ferocious, fang-bearing creature that resembles a fish."
	icon = 'icons/mob/carp.dmi'
	icon_state = "base"
	icon_living = "base"
	icon_dead = "base_dead"
	icon_gib = "carp_gib"
	speak_emote = list("glubs")
	emote_hear = list("glubs.")
	emote_see = list("glubs.")
	speak_chance = 1
	faction = list("beach")
	turns_per_move = 5
	butcher_results = list(/obj/item/reagent_containers/food/snacks/carpmeat = 2)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "punches"
	response_harm_simple = "punch"
	stop_automated_movement = 1
	friendly_verb_continuous = "nibbles"
	friendly_verb_simple = "nibble"

/mob/living/simple_animal/voidcarp/Life()
	..()
	//CARP movement
	if(!ckey && !stat)
		if(isturf(loc) && !resting && !buckled)		//This is so it only moves if it's not inside a closet, gentics machine, etc.
			turns_since_move++
			if(turns_since_move >= turns_per_move)
				var/east_vs_west = pick(4,8)
				if(Process_Spacemove(east_vs_west))
					Move(get_step(src,east_vs_west), east_vs_west)
					turns_since_move = 0
	regenerate_icons()
