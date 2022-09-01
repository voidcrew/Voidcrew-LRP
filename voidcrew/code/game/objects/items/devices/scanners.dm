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
	name = "Biological Scanner"
	desc = "A small device that performs a detailed scan of various living or descesed beings and uploads the collected data to a connected research server."
	icon = 'icons/obj/device.dmi'
	icon_state = "forensicnew" // should be temp
	w_class = WEIGHT_CLASS_SMALL
	item_state = "electronic" // should be temp
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi' // should be temp
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi' // should be temp
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 3
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	var/datum/techweb/stored_research
	var/value = 0 // the actual reward
	var/reward = 1500 // base reward before bonus, todo: make this a var in /mob/

/obj/item/bio_scanner/attack(mob/living/M, mob/living/user)
	if(istype(M, /mob/living)) //Scanning
		var/mob/living/mob = M
		if(!stored_research)
			playsound(loc, 'sound/effects/zzzt.ogg', 25, TRUE)
			say("Cannot scan. Not connected to a research server! Tap server with device to link.")
		else if(stored_research.scanned_mobs.Find(mob.name))
			playsound(loc, 'sound/effects/zzzt.ogg', 25, TRUE)
			say("Scan failed. Already scanned!")
		else
			stored_research.scanned_mobs.Add(mob.name)
			getvalue(mob)
			stored_research.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = value))
			say("Sucessfully scanned. [value] points added to database.")
			playsound(loc, 'sound/effects/adminhelp.ogg', 25, TRUE) //lul

/obj/item/bio_scanner/AltClick(mob/user)
	stored_research = null
	say("Cleared linked techweb!")

/obj/item/bio_scanner/proc/getvalue(mob/living/M) // Copy pasted from experimental_disection.dm I'll be working on a PR soon to give /mob a new var that hold its point reward, so no more of this bs
	var/mob/living/target = M
	if(isalienroyal(target))
		value = (reward*10)
	else if(isalienadult(target))
		value = (reward*5)
	else if(ismonkey(target))
		value = (reward*0.5)
	else if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H?.dna?.species)
			if(isabductor(H))
				value = (reward*4)
			else if(isgolem(H) || iszombie(H))
				value = (reward*3)
			else if(isjellyperson(H) || ispodperson(H))
				value = (reward*2)
	else
		value = (reward * 0.6)
