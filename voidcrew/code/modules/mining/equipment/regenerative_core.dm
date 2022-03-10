/// VC REAGENT TODO: All this grinding stuff was originally part of base tg regen cores but was removed. 
/// I ported it to this specific core since the whitesands version had it but due to the reagents not being ported i'm leaving it as TODO.

/obj/item/organ/regenerative_core/legion/crystal
	name = "crystal heart"
	desc = "A strange rock in the shape of a heart symbol. Applying will repair your body with crystals, but may have additional side effects. It seems it can't survive for very long outside a host."
	//grind_results = list(/datum/reagent/ash = 30)
	
///obj/item/organ/regenerative_core/legion/crystal/Initialize()
	//. = ..()
	//preserved_grind_results = list(/datum/reagent/medicine/soulus = rand(1, 30), /datum/reagent/ash = 30, /datum/reagent/determination = 1)
	//unpreserved_grind_results = list(/datum/reagent/medicine/soulus = 30, /datum/reagent/blood = rand(5, 15), /datum/reagent/determination = 1)

///obj/item/organ/regenerative_core/legion/crystal/on_grind()
//	if(inert) // Sanity check
//		return -1
//	if (preserved)
//		grind_results = preserved_grind_results
//	else
//		grind_results = unpreserved_grind_results
//	. = ..()

/obj/item/organ/regenerative_core/legion/crystal/applyto(atom/target, mob/user)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(inert)
			to_chat(user, span_notice("[src] has broken and can no longer be used to heal."))
			return
		else
			if(H.stat == DEAD)
				to_chat(user, span_notice("[src] is useless on the dead."))
				return
			if(H != user)
				H.visible_message(span_notice("[user] forces [H] to apply [src]... Cancer like crystals grow on and reinforce [H.p_them()]!"))
				SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "used", "other"))
			else
				to_chat(user, span_notice("You start to apply [src] on yourself. Cancer like crystals hold you together and add something to you to keep yourself moving, but for how long?"))
				SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "used", "self"))
			H.apply_status_effect(/datum/status_effect/regenerative_core)
			H.reagents.add_reagent(/datum/reagent/determination, 4)
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "core", /datum/mood_event/healsbadman) //Now THIS is a miner buff (fixed - nerf)
			qdel(src)

/obj/item/organ/regenerative_core/legion/crystal/update_icon_state()
	icon_state = inert ? "crystal_heart_inert" : "crystal_heart"
	if(preserved)
		icon_state = "crystal_heart_preserved"