/obj/item/pushbroom
	name = "push broom"
	desc = "This is my BROOMSTICK! It can be used manually or braced with two hands to sweep items as you move. It has a telescopic handle for compact storage."
	icon = 'icons/obj/janitor.dmi'
	icon_state = "broom0"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	force = 8
	throwforce = 10
	throw_speed = 3
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("swept", "brushed off", "bludgeoned", "whacked")
	resistance_flags = FLAMMABLE
	custom_materials = list(/datum/material/iron = 2000) // WS Edit - Item Materials

/obj/item/pushbroom/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)

/obj/item/pushbroom/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=8, force_wielded=12, icon_wielded="broom1")

/obj/item/pushbroom/update_icon_state()
	icon_state = "broom0"

/// triggered on wield of two handed item
/obj/item/pushbroom/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	to_chat(user, "<span class='notice'>You brace the [src] against the ground in a firm sweeping stance.</span>")
	RegisterSignal(user, COMSIG_MOVABLE_PRE_MOVE, .proc/sweep)

/// triggered on unwield of two handed item
/obj/item/pushbroom/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	UnregisterSignal(user, COMSIG_MOVABLE_PRE_MOVE)

/obj/item/pushbroom/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	sweep(user, A)

/obj/item/pushbroom/proc/sweep(mob/user, atom/A)
	SIGNAL_HANDLER

	var/turf/current_item_loc = isturf(A) ? A : A.loc
	if(!isturf(current_item_loc))
		return
	var/turf/new_item_loc = get_step(current_item_loc, user.dir)
	var/obj/machinery/disposal/bin/target_bin = locate(/obj/machinery/disposal/bin) in new_item_loc.contents
	var/obj/machinery/smartfridge/compstorage/target_compstorage = locate(/obj/machinery/smartfridge/compstorage) in new_item_loc.contents
	var/i = 0
	for(var/obj/item/garbage in current_item_loc.contents)
		if(!garbage.anchored)
			if(target_bin)
				garbage.forceMove(target_bin)
			else if(target_compstorage)
				if(target_compstorage.accept_check(garbage)) //compstorage can't accept backpacks so we run a check here
					target_compstorage.load(garbage)
					if(target_compstorage.visible_contents) //compstorage has visible contents on by default but just in case it doesn't
						target_compstorage.update_icon()
				else
					to_chat(user, "<span class='warning'>\The [src] smartly refuses [garbage].</span>")
					continue //if the check doesn't go through, we don't move the item at all
			else
				garbage.Move(new_item_loc, user.dir)
			i++
		if(i > 19)
			break
	if(i > 0)
		if(target_bin)
			target_bin.update_icon()
			to_chat(user, "<span class='notice'>You sweep the pile of garbage into [target_bin].</span>")
		if(target_compstorage)
			target_compstorage.update_icon()
			to_chat(user, "<span class='notice'>You sweep the pile of items into [target_compstorage].</span>")
		playsound(loc, 'sound/weapons/thudswoosh.ogg', 30, TRUE, -1)

/obj/item/pushbroom/proc/janicart_insert(mob/user, obj/structure/janitorialcart/J) //bless you whoever fixes this copypasta
	J.put_in_cart(src, user)
	J.mybroom=src
	J.update_icon()
