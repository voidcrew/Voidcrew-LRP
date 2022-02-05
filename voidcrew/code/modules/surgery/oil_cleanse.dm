// todo just make this a sub type of tend woudns and put in the mechanical surgery folder too


/datum/surgery/oil_cleanse
	name = "Oil Cleanse"
	desc = "Clean the oil within an IPC."
	target_mobtypes = list(/mob/living/carbon/human/species/ipc)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/cleanse_oil,
		/datum/surgery_step/mechanic_close
	)
	requires_bodypart_type = BODYTYPE_ROBOTIC
	possible_locs = list(BODY_ZONE_CHEST)
	lying_required = TRUE

/datum/surgery/oil_cleanse/can_start(mob/user, mob/living/carbon/target)
	if(!..())
		return FALSE
	return isipc(target)

/datum/surgery_step/cleanse_oil
	name = "cleanse oil"
	implements = list(/obj/item/oil_cleanser = 100, /obj/item/reagent_containers/syringe = 30)
	time = 5

/datum/surgery_step/oil_cleanse/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You prepare to clean out the oil running through [target].</span>",
		"<span class='notice'>[user] prepares to cleanse [target] with [tool].</span>",
		"<span class='notice'>[user] prepares to cleanse [target] with [tool].</span>")


/datum/surgery_step/oil_cleanse/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	display_results(user, target, "<span class='notice'>You successfully cleanse [target]'s oil with [tool]...</span>",
		"<span class='notice'>[user] pumps some oil in and out of [target] with [tool]...</span>",
		"<span class='notice'>[user] pumps some oil in and out of [target] with [tool]...</span>")
	target.adjustToxLoss(-5)

/datum/surgery_step/revive/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>The oil seems to be even dirtier than before...</span>",
		"<span class='notice'>[user] pumps dirty oil back into [target] with [tool]...</span>",
		"<span class='notice'>[user] pumps dirty oil back into [target] with [tool]...</span>")
	target.adjustToxLoss(5)
