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
	name = "Behavioral Analyzer"
	desc = "A small device that scans the brain patterns of a living mob and uploads their data to a connected research server."
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

/obj/item/bio_scanner/attack(mob/dead/M, mob/living/user)
	if(istype(M, /mob/dead)) //Scanning
		var/mob/dead/mob = M
		if(!stored_research)
			playsound(loc, 'sound/effects/zzzt.ogg', 25, TRUE)
			say("Cannot scan. Not connected to a research server! Tap server with device to link.")
		else if(stored_research.scanned_mobs.Find(mob.name))
			playsound(loc, 'sound/effects/zzzt.ogg', 25, TRUE)
			say("Scan failed. Already scanned!")
		else
			stored_research.scanned_mobs.Add(mob.name)
			stored_research.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = 1000))
			say("Sucessfully scanned. 1000 points added to database.")
			playsound(loc, 'sound/effects/adminhelp.ogg', 25, TRUE) //lul


/obj/item/bio_scanner/AltClick(mob/user)
	stored_research = null
	say("Cleared linked techweb!")

