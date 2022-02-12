/obj/item/stack/cable_coil/building_checks(datum/stack_recipe/noose_recipe, multiplier)
	if(noose_recipe.result_type == /obj/structure/chair/noose)
		if(!(locate(/obj/structure/chair) in get_turf(usr)))
			to_chat(usr, "<span class='warning'>You have to be standing on top of a chair to make a noose!</span>")
			return FALSE
	return ..()

/obj/structure/chair/noose //It's a "chair".
	name = "noose"
	desc = "Well this just got a whole lot more morbid."
	icon_state = "noose"
	icon = 'voidcrew/icons/obj/objects.dmi'
	layer = FLY_LAYER
	flags_1 = NODECONSTRUCT_1
	///So that the noose sprite can overlay the person beind hanged.
	var/mutable_appearance/overlay

/obj/structure/chair/noose/wirecutter_act(mob/user, params)
	. = ..()
	user.visible_message("[user] cuts the noose.", "<span class='notice'>You cut the noose.</span>")
	if(has_buckled_mobs())
		for(var/mob/living/buckled_mob in buckled_mobs)
			if(buckled_mob.has_gravity())
				buckled_mob.visible_message("<span class='danger'>[buckled_mob] falls over and hits the ground!</span>")
				to_chat(buckled_mob, "<span class='userdanger'>You fall over and hit the ground!</span>")
				buckled_mob.Knockdown(60)
				buckled_mob.adjustBruteLoss(10)
	var/obj/item/stack/cable_coil/dropped_cable = new(get_turf(src))
	dropped_cable.amount = 25
	qdel(src)
	return
		
/obj/structure/chair/noose/Initialize()
	. = ..()
	pixel_y += 16 //Noose looks like it's "hanging" in the air
	overlay = image(icon, "noose_overlay")
	overlay.layer = FLY_LAYER
	add_overlay(overlay)

/obj/structure/chair/noose/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/chair/noose/post_buckle_mob(mob/living/buckled_mob)
	if(has_buckled_mobs())
		src.layer = MOB_LAYER
		START_PROCESSING(SSobj, src)
		buckled_mob.dir = SOUTH
		animate(buckled_mob, pixel_y = initial(pixel_y) + 8, time = 8, easing = LINEAR_EASING)
	else
		layer = initial(layer)
		STOP_PROCESSING(SSobj, src)
		buckled_mob.pixel_x = initial(buckled_mob.pixel_x)
		pixel_x = initial(pixel_x)
		buckled_mob.pixel_y = buckled_mob.get_standard_pixel_y_offset(buckled_mob.lying_angle)

/obj/structure/chair/noose/user_unbuckle_mob(mob/living/target_mob,mob/living/user)
	if(has_buckled_mobs())
		if(target_mob != user)
			user.visible_message("<span class='notice'>[user] begins to untie the noose over [target_mob]'s neck...</span>")
			to_chat(user, "<span class='notice'>You begin to untie the noose over [target_mob]'s neck...</span>")
			if(!do_mob(user, target_mob, 100))
				return
			user.visible_message("<span class='notice'>[user] unties the noose over [target_mob]'s neck!</span>")
			to_chat(user,"<span class='notice'>You untie the noose over [target_mob]'s neck!</span>")
			target_mob.Knockdown(60)
		else
			target_mob.visible_message("<span class='warning'>[target_mob] struggles to untie the noose over their neck!</span>")
			to_chat(target_mob,"<span class='notice'>You struggle to untie the noose over your neck... (Stay still for 15 seconds.)</span>")
			if(!do_after(target_mob, 150, target = src))
				if(target_mob && target_mob.buckled)
					to_chat(target_mob, "<span class='warning'>You fail to untie yourself!</span>")
				return
			if(!target_mob.buckled)
				return
			target_mob.visible_message("<span class='warning'>[target_mob] unties the noose over their neck!</span>")
			to_chat(target_mob,"<span class='notice'>You untie the noose over your neck!</span>")
			target_mob.Knockdown(60)
		unbuckle_all_mobs(force=1)
		target_mob.pixel_z = initial(target_mob.pixel_z)
		pixel_z = initial(pixel_z)
		target_mob.pixel_x = initial(target_mob.pixel_x)
		pixel_x = initial(pixel_x)
		add_fingerprint(user)

/obj/structure/chair/noose/user_buckle_mob(mob/living/carbon/human/target_mob, mob/user, check_loc = TRUE)
	if(!in_range(user, src) || user.stat || HAS_TRAIT(user, TRAIT_RESTRAINED) || !iscarbon(target_mob))
		return FALSE

	if (!target_mob.get_bodypart("head"))
		to_chat(user, "<span class='warning'>[target_mob] has no head!</span>")
		return FALSE

	if(target_mob.loc != src.loc)
		return FALSE //Can only noose someone if they're on the same tile as noose

	add_fingerprint(user)
	log_combat(user, target_mob, "Attempted to Hang", src)
	target_mob.visible_message("<span class='danger'>[user] attempts to tie \the [src] over [target_mob]'s neck!</span>")
	if(user != target_mob)
		to_chat(user, "<span class='notice'>It will take 10 seconds and you have to stand still.</span>")
	if(do_mob(user, target_mob, user == target_mob ? 0:100))
		if(buckle_mob(target_mob))
			user.visible_message("<span class='warning'>[user] ties \the [src] over [target_mob]'s neck!</span>")
			if(user == target_mob)
				to_chat(target_mob, "<span class='userdanger'>You tie \the [src] over your neck!</span>")
			else
				to_chat(target_mob, "<span class='userdanger'>[user] ties \the [src] over your neck!</span>")
			playsound(user.loc, 'voidcrew/sound/effects/noosed.ogg', 50, 1, -1)
			log_combat(user, target_mob, "hanged", src)
			return TRUE
	user.visible_message("<span class='warning'>[user] fails to tie \the [src] over [target_mob]'s neck!</span>")
	to_chat(user, "<span class='warning'>You fail to tie \the [src] over [target_mob]'s neck!</span>")
	return FALSE


/obj/structure/chair/noose/process()
	if(!has_buckled_mobs())
		STOP_PROCESSING(SSobj, src)
		return
	for(var/mob/living/buckled_mob in buckled_mobs)
		if(pixel_x >= 0)
			animate(src, pixel_x = -3, time = 45, easing = ELASTIC_EASING)
			animate(buckled_mob, pixel_x = -3, time = 45, easing = ELASTIC_EASING)
		else
			animate(src, pixel_x = 3, time = 45, easing = ELASTIC_EASING)
			animate(buckled_mob, pixel_x = 3, time = 45, easing = ELASTIC_EASING)
		if(buckled_mob.has_gravity())
			if(buckled_mob.get_bodypart("head"))
				if(buckled_mob.stat != DEAD)
					if(!HAS_TRAIT(buckled_mob, TRAIT_NOBREATH))
						buckled_mob.adjustOxyLoss(5)
						if(prob(40))
							buckled_mob.emote("gasp")
					if(prob(20))
						var/flavor_text = list("<span class='suicide'>[buckled_mob]'s legs flail for anything to stand on.</span>",\
												"<span class='suicide'>[buckled_mob]'s hands are desperately clutching the noose.</span>",\
												"<span class='suicide'>[buckled_mob]'s limbs sway back and forth with diminishing strength.</span>")
						buckled_mob.visible_message(pick(flavor_text))
				playsound(buckled_mob.loc, 'voidcrew/sound/effects/noose_idle.ogg', 30, 1, -3)
			else
				buckled_mob.visible_message("<span class='danger'>[buckled_mob] drops from the noose!</span>")
				buckled_mob.Knockdown(60)
				buckled_mob.pixel_z = initial(buckled_mob.pixel_z)
				pixel_z = initial(pixel_z)
				buckled_mob.pixel_x = initial(buckled_mob.pixel_x)
				pixel_x = initial(pixel_x)
				unbuckle_all_mobs(force=1)


