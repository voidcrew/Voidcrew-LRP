/datum/reagent/consumable/sodiumchloride/expose_mob(mob/living/mob, method=TOUCH, reac_volume)
	. = ..()
	if (!issquidperson(mob))
		return
	if(reac_volume < 5)
		return

	if (method == INGEST)
		to_chat(mob, "<span class='danger'>Your tongue shrivels as you taste the salt!</span>")
		mob.adjustFireLoss(reac_volume / 2, TRUE)
	else if (method == TOUCH)
		mob.adjustFireLoss(reac_volume / 2, TRUE)
		if(!mob.incapacitated())
			var/obj/item/item = mob.get_active_held_item()
			mob.throw_item(get_ranged_target_turf(mob, pick(GLOB.alldirs), rand(1, 3)))
			to_chat(mob, "<span class='warning'>The salt causes your arm to spasm! It burns!</span>")
			mob.log_message("threw [item] due to a Muscle Spasm", INDIVIDUAL_ATTACK_LOG)
