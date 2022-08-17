/mob/living/simple_animal/hostile/asteroid/wolf/wasteland
	faction = list("wasteland")

/mob/living/simple_animal/hostile/asteroid/wolf/alpha/wasteland
	faction = list("wasteland")

/mob/living/simple_animal/hostile/asteroid/wolf/wasteland/random/Initialize()
	. = ..()
	if(prob(15))
		new /mob/living/simple_animal/hostile/asteroid/wolf/alpha/wasteland(loc)
		return INITIALIZE_HINT_QDEL
