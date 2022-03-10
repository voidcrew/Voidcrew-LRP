/obj/machinery/cassette/adv_cassette_deck
	name = "Advanced Cassette Deck"
	desc = "A more advanced less portable Cassette Deck. Useful for recording songs from our generation, or customizing the style of your cassettes."
	icon = 'voidcrew/icons/obj/machines/adv_cassette_deck.dmi'
	icon_state = "cassette_deck"
	density = TRUE
	//cassette tape used in adding songs or customizing
	var/obj/item/device/cassette_tape/tape
	var/datum/track/selection = null

/obj/machinery/cassette/adv_cassette_deck/attackby(obj/item/object, mob/user, params)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(object.tool_behaviour == TOOL_WRENCH)
			if(!anchored && !isinspace())
				to_chat(user,"<span class='notice'>You secure [src] to the floor.</span>")
				set_anchored(TRUE)
			else if(anchored)
				to_chat(user,"<span class='notice'>You unsecure and disconnect [src].</span>")
				set_anchored(FALSE)
			playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
			return
	return ..()

/obj/machinery/cassette/adv_cassette_deck/AltClick(mob/user)
	if(tape)
		eject_tape(user)
		return
	else
		..()

/obj/machinery/cassette/adv_cassette_deck/attackby(obj/item/cassette, mob/user)
	if(istype(cassette, /obj/item/device/cassette_tape))
		if(!tape)
			insert_tape(cassette)
			playsound(src,'sound/weapons/handcuffs.ogg',20,1)
			to_chat(user,("You insert \the [cassette] into \the [src]"))
		else
			to_chat(user,("Remove a tape first!"))

/obj/machinery/cassette/adv_cassette_deck/proc/insert_tape(obj/item/device/cassette_tape/CTape)
	if(tape || !istype(CTape)) return
	if(!tape)
		tape = CTape
		CTape.forceMove(src)
	else
		return
/obj/machinery/cassette/adv_cassette_deck/proc/eject_tape(mob/user)
	if(!tape) return
	if(tape)
		user.put_in_hands(tape)
		tape = null

/obj/machinery/cassette/adv_cassette_deck/ui_status(mob/user)
	if(!anchored)
		to_chat(user,"<span class='warning'>This device must be anchored by a wrench!</span>")
		return UI_CLOSE
	if(!allowed(user) && !isobserver(user))
		to_chat(user,"<span class='warning'>Error: Access Denied.</span>")
		user.playsound_local(src, 'sound/misc/compiler-failure.ogg', 25, TRUE)
		return UI_CLOSE
	return ..()

/obj/machinery/cassette/adv_cassette_deck/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "adv_cassette_deck", name)
		ui.open()

/obj/machinery/cassette/adv_cassette_deck/ui_data(mob/user)
	var/list/data = list()
	data["songs"] = list()
	for(var/datum/track/song in SSjukeboxes.songs) //WS Edit Cit #7367
		var/list/track_data = list(
			name = song.song_name
		)
		data["songs"] += list(track_data)
	data["track_selected"] = null
	if(selection)
		data["track_selected"] = selection.song_name
	return data

/obj/machinery/cassette/adv_cassette_deck/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("toggle")
			if(QDELETED(src))
				return
			if(tape.flipped == FALSE)
				tape.songs["side1"] += selection.song_path
				tape.song_names["side1"] += "Unknown Track"
			else
				tape.songs["side2"] += selection.song_path
				tape.song_names["side2"] += "Unknown Track"
		if("select_track")
			var/list/available = list()
			for(var/datum/track/song in SSjukeboxes.songs)
				available[song.song_name] = song
			var/selected = params["track"]
			selection = available[selected]
			return TRUE
