/obj/item/nanite_scanner
	name = "nanite scanner"
	icon = 'icons/obj/device.dmi'
	icon_state = "nanite_scanner"
	item_state = "nanite_remote"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	desc = "A hand-held body scanner able to detect nanites and their programming."
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 3
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=200)

/obj/item/nanite_scanner/attack(mob/living/M, mob/living/carbon/human/user)
	user.visible_message(
		"<span class='notice'>[user] analyzes [M]'s nanites.</span>", \
		"<span class='notice'>You analyze [M]'s nanites.</span>",
	)

	add_fingerprint(user)

	var/response = SEND_SIGNAL(M, COMSIG_NANITE_SCAN, user, TRUE)
	if(!response)
		to_chat(user, "<span class='info'>No nanites detected in the subject.</span>")

/obj/item/bio_scanner
	name = "bio scanner"
	icon = 'icons/obj/device.dmi'
	icon_state = "forensicnew"
	w_class = WEIGHT_CLASS_SMALL
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 3
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	var/datum/techweb/stored_research

/obj/item/bio_scanner/attack(mob/living/M, mob/living/user)
	if(istype(D, /obj/item/multitool))	//Linking
		var/obj/item/multitool/multi = D
		if(istype(multi.buffer, /obj/machinery/rnd/server))
			visible_message("Connected to Server.")
			connect_to_server(multi.buffer)
			return
		if(stored_research)
			visible_message("Disconnected from Server.")
			disconnect_from_server()
			return
	elif(istype(D, /mob/living)) //Scanning
		/mob/living = D
		if(!stored_research.scanned_mobs.find(D.name))
			stored_research.scanned_mobs.add(D.name)
			visible_message("Scanner linked to server.")
			playsound(loc, 'sound/effects/', 25, TRUE)

/obj/item/bio_scanner/proc/connect_to_server(obj/machinery/rnd/server/server)
	if(stored_research)
		disconnect_from_server()
	stored_research = server.stored_research

/obj/item/bio_scanner/proc/disconnect_from_server()
	stored_research = null

