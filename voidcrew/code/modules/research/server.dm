/obj/machinery/rnd/server/multitool_act(mob/living/user, obj/item/multitool)
	var/obj/item/multitool/multi = multitool
	multi.buffer = src
	to_chat(user, "<span class='notice'>[src] stored in [multitool].</span>")
	return TRUE

/obj/machinery/rnd/server/attackby(obj/item/object, mob/living/user, params)
	if(istype(object, /obj/item/bio_scanner))
		var/obj/item/bio_scanner/scanner = object
		if(!scanner.stored_research)
			scanner.stored_research += stored_research
			visible_message("The servers status display briefly flashes: \"CONNECTED\".")
		else
			visible_message("The servers status display briefly errors: \"ALREADY CONNECTED TO A SERVER\".")
	return ..()
