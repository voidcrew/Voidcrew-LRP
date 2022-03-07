/datum/component/seacrystal
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS
	var/summon_cooldown = 20 SECONDS
	var/newcolor = rgb(10, 75, 149)
	var/charging = FALSE
	var/damage_coeff = list(BRUTE = 1, BURN = 0.5, TOX = 0.5, CLONE = 0.5, STAMINA = 0, OXY = 0.5)


/datum/component/seacrystal/Initialize(_summon_cooldown = 20, _newcolor = rgb(10, 75, 149), _charging = FALSE, _damage_coeff)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	if(_summon_cooldown)
		summon_cooldown = _summon_cooldown
	if(_newcolor)
		newcolor = _newcolor
	if(_charging)
		charging = _charging
	if(_damage_coeff)
		damage_coeff = _damage_coeff
	RegisterSignal(parent, list(COMSIG_PARENT_ATTACKBY, COMSIG_ATOM_BULLET_ACT), .proc/summon_minions)

/datum/component/seacrystal/proc/summon_minions()
	var/obj/P = parent
	if(summon_cooldown > world.time || charging)
		return
	charging = TRUE
	crypower()
	var/turf/T = get_turf(P.loc)
	var/turf/X1 = get_step(T, pick(1,2))
	var/turf/X2 = get_step(T, pick(4,8))
	telegraph()
	new /obj/effect/temp_visual/seacrystal/sparks(X1)
	new /obj/effect/temp_visual/seacrystal/sparks(X2)
	telegraph()
	new /obj/effect/temp_visual/seacrystal/sparks(X1)
	new /obj/effect/temp_visual/seacrystal/sparks(X2)
	new /obj/effect/temp_visual/seacrystal/jaunt/out(X1)
	new /obj/effect/temp_visual/seacrystal/jaunt/out(X2)
	playsound(P.loc,'sound/magic/exit_blood.ogg', 200, 1)
	new /mob/living/simple_animal/hostile/asteroid/hivelord/beach(X1)
	new /mob/living/simple_animal/hostile/asteroid/hivelord/beach(X2)
	P.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, newcolor)
	crydepower()
	summon_cooldown = (world.time + initial(summon_cooldown))
	charging = FALSE

/datum/component/seacrystal/proc/crypower()
	var/obj/P = parent
	damage_coeff = list(BRUTE = 0.6, BURN = 0.2, TOX = 0.2, CLONE = 0.2, STAMINA = 0, OXY = 0.2)
	P.add_atom_colour(newcolor, TEMPORARY_COLOUR_PRIORITY)
	new /obj/effect/temp_visual/seacrystal/sparks(get_turf(P.loc))

/datum/component/seacrystal/proc/crydepower()
	var/obj/P = parent
	damage_coeff = list(BRUTE = 1, BURN = 0.5, TOX = 0.5, CLONE = 0.5, STAMINA = 0, OXY = 0.5)
	P.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, newcolor)
	new /obj/effect/temp_visual/seacrystal/sparks(get_turf(P.loc))

/datum/component/seacrystal/proc/telegraph()
	var/obj/P = parent
	for(var/mob/M in range(10,P.loc))
		if(M.client)
			flash_color(M.client, "#0071f1", 2)
			shake_camera(M, 2, 1)
	playsound(P.loc, 'sound/magic/clockwork/narsie_attack.ogg', 200, TRUE)
	// playsound(P.loc, 'sound/magic/demon_dies.ogg', 200, TRUE)
