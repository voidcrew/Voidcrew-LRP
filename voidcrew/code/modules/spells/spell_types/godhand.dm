/obj/item/melee/touch_attack/crystalize
	name = "\improper crystalizing touch"
	desc = "Stop your enemies in their tracks. Put them in your house as decorations."
	catchphrase = "Stop."
	on_use_sound = 'sound/magic/fleshtostone.ogg'
	icon_state = "zapper"
	item_state = "zapper"

/obj/item/melee/touch_attack/crystalize/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!proximity || target == user || !isliving(target) || !iscarbon(user))
		return
	if(!(user.mobility_flags & MOBILITY_USE))
		to_chat(user, "<span class='warning'>You can't reach out!</span>")
		return
	if(!user.can_speak_vocal())
		to_chat(user, "<span class='warning'>You can't get the words out!</span>")
		return
	var/mob/living/victim = target
	if(victim.anti_magic_check())
		to_chat(user, "<span class='warning'>The spell can't seem to affect [victim]!</span>")
		..()
		return
	victim.Paralyze(20)
	victim.apply_status_effect(/datum/status_effect/freon)
	return ..()
