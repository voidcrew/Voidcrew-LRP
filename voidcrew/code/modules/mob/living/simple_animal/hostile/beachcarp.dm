/mob/living/simple_animal/hostile/carp/beach
	faction = list("beach")
	name = "judge"
	desc = "A large, ferocious fish with massive fangs. It appears ready to attack."
	icon = 'voidcrew/icons/mob/beach/aquatic.dmi'
	icon_state = "judge"
	icon_dead = "judge_dead" // lol
	maxHealth = 40
	health = 40

/mob/living/simple_animal/hostile/carp/beach/Life()
	..()
	//CARP movement
	if(!ckey && !stat)
		if(isturf(loc) && !resting && !buckled) //This is so it only moves if it's not inside a closet, gentics machine, etc.
			turns_since_move++
			if(turns_since_move >= turns_per_move)
				var/east_vs_west = pick(4,8)
				if(Process_Spacemove(east_vs_west))
					var/turf/step = get_step(src,east_vs_west)
					if (istype(step, /turf/open/water)) //Only allow fish to move onto water tiles
						Move(step, east_vs_west)
					turns_since_move = 0
	regenerate_icons()

/mob/living/simple_animal/hostile/carp/beach/small
	name = "grump"
	desc = "A small, menacing fish with large fangs. It appears ready to attack."
	icon = 'voidcrew/icons/mob/beach/aquatic.dmi'
	icon_state = "grump"
	icon_dead = "grump_dead"
	maxHealth = 10
	health = 10

/mob/living/simple_animal/hostile/carp/megacarp/beach
	name = "shark"
	desc = "A vicious shark. It seems to have a lust for blood. Your blood."
	faction = list("beach")
	icon = 'voidcrew/icons/mob/beach/aquatic.dmi'
	icon_state = "shark"
	icon_dead = "shark_dead"
	pixel_x = 0
	maxHealth = 50
	health = 50
