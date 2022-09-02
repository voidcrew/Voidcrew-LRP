/obj/machinery/rnd/server/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/multitool))
		var/obj/item/multitool/multi = O
		multi.buffer = src
		to_chat(user, "<span class='notice'>[src] stored in [O].</span>")
		return TRUE
	if(istype(O, /obj/item/bio_scanner))
		var/obj/item/bio_scanner/scanner = O
		if(!scanner.stored_research)
			scanner.stored_research += stored_research
			visible_message("The servers status display briefly flashes: \"CONNECTED\".")
		else
			visible_message("The servers status display briefly errors: \"ALREADY CONNECTED TO A SERVER\".")
	return ..()
