/obj/effect/decal/cleanable/food/salt/Crossed(atom/movable/atom)
	. = ..()
	if(!issquidperson(atom))
		return
	var/mob/living/carbon/human/squid = atom
	if(squid.movement_type & FLYING)
		return
	squid.adjustFireLoss(2, TRUE)
	squid.reagents.add_reagent(/datum/reagent/consumable/sodiumchloride, 5)
	playsound(squid, 'sound/weapons/sear.ogg', 50, TRUE)
	to_chat(squid, "<span class='userdanger'>[src] burns you!</span>")
