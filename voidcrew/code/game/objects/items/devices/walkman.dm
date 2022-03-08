#define sound_to(target, sound)                             target << (sound)
/obj/item/device/walkman
	name = "walkman"
	desc = "A cassette player that first hit the market over 200 years ago. Crazy how these never went out of style."
	icon = 'voidcrew/icons/obj/walkman.dmi'
	icon_state = "walkman"
	w_class = WEIGHT_CLASS_SMALL
	actions_types = list(/datum/action/item_action/walkman/play_pause,/datum/action/item_action/walkman/next_song,/datum/action/item_action/walkman/restart_song)
	var/obj/item/device/cassette_tape/tape
	var/paused = TRUE
	var/list/current_playlist = list()
	var/list/current_songnames = list()
	var/sound/current_song
	var/mob/current_listener
	var/pl_index = 1
	var/volume = 25
	var/design = 1 // What kind of walkman design style to use

/obj/item/device/walkman/Initialize()
	. = ..()
	design = rand(1, 5)
	update_icon()

/obj/item/device/walkman/Destroy()
	QDEL_NULL(tape)
	break_sound()
	current_song = null
	current_listener = null
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/device/walkman/attackby(obj/item/cassette, mob/user)
	if(istype(cassette, /obj/item/device/cassette_tape))
		if(!tape)
			insert_tape(cassette)
			playsound(src,'sound/weapons/handcuffs.ogg',20,1)
			to_chat(user,("You insert \the [cassette] into \the [src]"))
		else
			to_chat(user,("Remove the other tape first!"))

/obj/item/device/walkman/attack_self(mob/user)
	..()

	if(!current_listener)
		current_listener = user
		START_PROCESSING(SSobj, src)
	if(istype(tape))
		if(paused)
			play()
			to_chat(user,("You press [src]'s 'play' button"))
		else
			pause()
			to_chat(user,("You pause [src]"))
		update_icon()
	else
		to_chat(user,("There's no tape to play"))
	playsound(src,'sound/machines/click.ogg',20,1)

/obj/item/device/walkman/AltClick(mob/user)
	if(tape)
		eject_tape(user)
		return
	else
		..()

/obj/item/device/walkman/proc/break_sound()
	var/sound/break_sound = sound(null, 0, 0, SOUND_CHANNEL_WALKMAN)
	break_sound.priority = 255
	update_song(break_sound, current_listener, 0)

/obj/item/device/walkman/proc/update_song(sound/S, mob/M, flags = SOUND_UPDATE)
	if(!istype(M) || !istype(S)) return
	if(HAS_TRAIT(M, TRAIT_DEAF))
		flags |= SOUND_MUTE
	S.status = flags
	S.volume = src.volume
	S.channel = SOUND_CHANNEL_WALKMAN
	sound_to(M,S)

/obj/item/device/walkman/proc/pause(mob/user)
	if(!current_song) return
	paused = TRUE
	update_song(current_song,current_listener, SOUND_PAUSED | SOUND_UPDATE)

/obj/item/device/walkman/proc/play()
	if(!current_song)
		if(current_playlist.len > 0)
			current_song = sound(current_playlist[pl_index], 0, 0, SOUND_CHANNEL_WALKMAN, volume)
			current_song.status = SOUND_STREAM
		else
			return
	paused = FALSE
	if(current_song.status & SOUND_PAUSED)
		update_song(current_song,current_listener)
	else
		update_song(current_song,current_listener,0)

	update_song(current_song,current_listener)

/obj/item/device/walkman/proc/insert_tape(obj/item/device/cassette_tape/CT)
	if(tape || !istype(CT)) return

	tape = CT
	if(ishuman(CT.loc))
		var/mob/living/carbon/human/H = CT.loc
		//H.drop_held_item(CT) Gonna need to reformat this i think
	CT.forceMove(src)

	update_icon()
	paused = TRUE
	pl_index = 1
	if(tape.songs["side1"] && tape.songs["side2"])
		var/list/L = tape.songs["[tape.flipped ? "side2" : "side1"]"]
		for(var/S in L)
			current_playlist += S
			current_songnames += L[S]


/obj/item/device/walkman/proc/eject_tape(mob/user)
	if(!tape) return

	break_sound()

	current_song = null
	current_playlist.Cut()
	current_songnames.Cut()
	user.put_in_hands(tape)
	paused = TRUE
	tape = null
	update_icon()
	playsound(src,'sound/weapons/handcuffs.ogg',20,1)

/obj/item/device/walkman/proc/next_song(mob/user)

	if(current_playlist.len == 0) return

	break_sound()

	if(pl_index + 1 <= current_playlist.len)
		pl_index++
	else
		pl_index = 1
	current_song = sound(current_playlist[pl_index], 0, 0, SOUND_CHANNEL_WALKMAN, volume)
	current_song.status = SOUND_STREAM
	play()



/obj/item/device/walkman/update_icon()
	..()
	overlays.Cut()
	if(design)
		overlays += "+[design]"
	if(tape)
		if(!paused)
			overlays += "+playing"
	else
		overlays += "+empty"

	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.regenerate_icons()

/obj/item/device/walkman/process()
	if(!(src in current_listener.GetAllContents()) || current_listener.stat & DEAD)
		if(current_song)
			current_song = null
		to_chat(current_listener, "Stopping Music :)")
		break_sound()
		paused = TRUE
		current_listener = null
		update_icon()
		STOP_PROCESSING(SSobj, src)
		return

	if(HAS_TRAIT(current_listener, TRAIT_DEAF) && current_song && !(current_song.status & SOUND_MUTE))
		update_song(current_song, current_listener)
	if(!HAS_TRAIT(current_listener, TRAIT_DEAF) && current_song && current_song.status & SOUND_MUTE)
		update_song(current_song, current_listener)

/obj/item/device/walkman/verb/play_pause()
	set name = "Play/Pause"
	set category = "Object"
	set src in usr

	//if(usr.is_mob_incapacitated()) return

	attack_self(usr)

/obj/item/device/walkman/verb/eject_cassetetape()
	set name = "Eject tape"
	set category = "Object"
	set src in usr

	eject_tape(usr)

/obj/item/device/walkman/verb/next_pl_song()
	set name = "Next song"
	set category = "Object"
	set src in usr

	next_song(usr)

/obj/item/device/walkman/verb/change_volume()
	set name = "Change Walkman volume"
	set category = "Object"
	set src in usr

	if(!current_song) return

	var/tmp = input(usr,"Change the volume (0 - 100)","Volume") as num|null
	if(tmp == null) return
	if(tmp > 100) tmp = 100
	if(tmp < 0) tmp = 0
	volume = tmp
	update_song(current_song, current_listener)

/obj/item/device/walkman/proc/restart_song(mob/user)
	if(!current_song) return

	update_song(current_song, current_listener, 0)

/obj/item/device/walkman/verb/restart_current_song()
	set name = "Restart Song"
	set category = "Object"
	set src in usr

	restart_song(usr)

/*

	ACTION BUTTONS

*/

/datum/action/item_action/walkman

/datum/action/item_action/walkman/New()
	..()
	button.overlays += image('voidcrew/icons/obj/walkman.dmi', button, icon_icon)

/datum/action/item_action/walkman/play_pause
	icon_icon = "walkman_playpause"

/datum/action/item_action/walkman/play_pause/New()
	..()
	name = "Play/Pause"
	button.name = name

/datum/action/item_action/walkman/play_pause/Trigger()
	if(target)
		var/obj/item/device/walkman/WM = target
		WM.attack_self(owner)

/datum/action/item_action/walkman/next_song
	icon_icon = "walkman_next"

/datum/action/item_action/walkman/next_song/New()
	..()
	name = "Next song"
	button.name = name

/datum/action/item_action/walkman/next_song/Trigger()
	if(target)
		var/obj/item/device/walkman/WM = target
		WM.next_song(owner)

/datum/action/item_action/walkman/restart_song
	icon_icon = "walkman_restart"

/datum/action/item_action/walkman/restart_song/New()
	..()
	name = "Restart song"
	button.name = name

/datum/action/item_action/walkman/restart_song/Trigger()
	if(target)
		var/obj/item/device/walkman/WM = target
		WM.restart_song(owner)

/*
	TAPES
*/
/obj/item/device/cassette_tape
	name = "cassette Tape"
	desc = "A cassette tape"
	icon = 'voidcrew/icons/obj/walkman.dmi'
	icon_state = "cassette_flip"
	w_class = WEIGHT_CLASS_SMALL
	var/side1_icon = "cassette"
	var/flipped = FALSE //Tape side
	var/list/songs = list()
	var/id = 1

/obj/item/device/cassette_tape/attack_self(mob/user)
	..()

	if(flipped == TRUE)
		flipped = FALSE
		icon_state = side1_icon
	else
		flipped = TRUE
		icon_state = "cassette_flip"
	to_chat(user,"You flip [src]")

/obj/item/device/cassette_tape/verb/flip()
	set name = "Flip tape"
	set category = "Object"
	set src in usr

	attack_self()

/obj/item/device/cassette_tape/pop2
	name = "rainbow cassette"
	id = 3
	desc = "A plastic cassette tape with a rainbow colored sticker."
	icon_state = "cassette_rainbow"
	side1_icon = "cassette_rainbow"
	songs = list("side1" = list("voidcrew/sound/music/walkman/pop2/2-1-1.ogg"),
				 "side2" = list("voidcrew/sound/music/walkman/pop2/2-2-1.ogg"))

/obj/item/device/cassette_tape/ftl
	name = "Faster Than Light cassette"
	id = 4
	desc = "A plastic cassette tape with a animated purple sticker."
	icon_state = "cassette_ftl"
	side1_icon = "cassette_ftl"
	songs = list("side1" = list("voidcrew/sound/music/walkman/ftl/3-1-1.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-1.ogg"),
				 "side2" = list("voidcrew/sound/music/walkman/ftl/3-2-1.ogg"))

