/mob/living/simple_animal/hostile/carp/beach
	faction = list("beach")
	icon = 'voidcrew/icons/mob/beach/aquatic.dmi'
	icon_state = "judge"
	icon_dead = "judge_dead"
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
	icon = 'voidcrew/icons/mob/beach/aquatic.dmi'
	icon_state = "grump"
	icon_dead = "grump_dead"

/mob/living/simple_animal/hostile/carp/megacarp/beach
	faction = list("beach")
	icon = 'voidcrew/icons/mob/beach/aquatic.dmi'
	icon_state = "shark"
	icon_dead = "shark_dead"
	maxHealth = 70
	health = 70
