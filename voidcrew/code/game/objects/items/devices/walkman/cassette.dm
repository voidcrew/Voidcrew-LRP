/obj/item/device/cassette_tape
	name = "Debug Cassette Tape"
	desc = "You shouldn't be seeing this!"
	icon = 'voidcrew/icons/obj/walkman.dmi'
	icon_state = "cassette_flip"
	w_class = WEIGHT_CLASS_SMALL
	///icon of the cassettes front side
	var/side1_icon = "cassette_worstmap"
	var/side2_icon = "cassette_worstmap"
	///if the cassette is flipped, for playing second list of songs
	var/flipped = FALSE
	///list of songs each side has to play
	var/list/songs = list("side1" = list(),
						  "side2" = list())
	///list of each songs name in the order they appear
	var/list/song_names = list("side1" = list(),
						 	   "side2" = list())
	///the id of the cassette
	var/id = 1
	//the cassette_tape type datum
	var/datum/cassette/cassette_tape/tape

/obj/item/device/cassette_tape/Initialize()
	. = ..()
	tape = new tape
	name = tape.name
	desc = tape.desc
	icon_state = tape.icon_state
	side1_icon = tape.side1_icon
	side2_icon = tape.side2_icon
	id = tape.id
	songs = tape.songs
	song_names = tape.song_names
	qdel(tape)

/obj/item/device/cassette_tape/attack_self(mob/user)
	..()

	icon_state = flipped ? side1_icon : side2_icon
	flipped = !flipped
	to_chat(user,"You flip [src]")

/obj/item/device/cassette_tape/attackby(obj/item/item, mob/living/user)
	if(!istype(item, /obj/item/pen))
		return
	var/choice = input("What would you like to change?") in list("Cassette Name", "Cassette Description", "Cancel")
	switch(choice)
		if("Cassette Name")
			///the name we are giving the cassette
			var/newcassettename = reject_bad_text(stripped_input(user, "Write a new Cassette name:", name, name))
			if(!user.canUseTopic(src, BE_CLOSE))
				return
			if (length(newcassettename) > 20)
				to_chat(user, "<span class='warning'>That name is too long!</span>")
				return
			if(!newcassettename)
				to_chat(user, "<span class='warning'>That name is invalid.</span>")
				return
			else
				name = "[lowertext(newcassettename)]"
		if("Cassette Description")
			///the description we are giving the cassette
			var/newdesc = stripped_input(user, "Write a new description:", name, desc)
			if(!user.canUseTopic(src, BE_CLOSE))
				return
			if (length(newdesc) > 180)
				to_chat(user, "<span class='warning'>That description is too long!</span>")
				return
			if(!newdesc)
				to_chat(user, "<span class='warning'>That description is invalid.</span>")
				return
			else
				desc = newdesc
		else
			return

/datum/cassette/cassette_tape
	var/name = "Broken Cassette"
	var/desc = "You shouldn't be seeing this! Make an issue about it"
	var/icon_state = "cassette_flip"
	var/side1_icon = "cassette_flip"
	var/side2_icon = "cassette_flip"
	var/id = 1
	var/list/song_names = list("side1" = list(),
							   "side2" = list())

	var/list/songs = list("side1" = list(),
						  "side2" = list())

/datum/cassette/cassette_tape/blank
	name = "Blank Cassette"
	desc = "A plastic cassette tape"
	icon_state = "cassette_flip"
	side1_icon = "cassette_flip"
	id = 2
	song_names = list("side1" = list("test",\
									 "test2"),
					  "side2" = list())

	songs = list("side1" = list("https://www.youtube.com/watch?v=uChyiLL621Y&list=RDuChyiLL621Y&start_radio=1",\
								"voidcrew/sound/music/walkman/ftl/3-1-1.ogg"),
				 "side2" = list())

/obj/item/device/cassette_tape/blank
	tape = /datum/cassette/cassette_tape/blank

/datum/cassette/cassette_tape/ftl
	name = "Faster Than Light cassette"
	id = 3
	desc = "A plastic cassette tape with a ftl themed sticker."
	icon_state = "cassette_ftl"
	side1_icon = "cassette_ftl"
	side1_icon = "cassette_flip"
	song_names = list("side1" = list("Milky Way(Explore)",\
									 "Civil(Explore)",\
									 "Cosmos(Explore)",\
									 "Deepspace(Explore)",\
									 "Debris(Explore)",\
									 "Mantis(Explore)",\
									 "Engi(Explore)",\
									 "Colonial(Explore)",\
									 "Wasteland(Explore)",\
									 "Rockmen(Explore)",\
									 "Void(Explore)",\
									 "Zoltan(Explore)",\
									 "Hacking Malfunction(Explore)",\
									 "Lanius(Explore)",\
									 "Lost Ship(Explore)",\
									 "Slug(Explore)",\
									 "Bonus"),

					  "side2" = list("Milky Way(Battle)",\
									 "Civil(Battle)",\
									 "Cosmos(Battle)",\
									 "Deepspace(Battle)",\
									 "Debris(Battle)",\
									 "Mantis(Battle)",\
									 "Engi(Battle)",\
									 "Colonial(Battle)",\
									 "Wasteland(Battle)",\
									 "Rockmen(Battle)",\
									 "Void(Battle)",\
									 "Zoltan(Battle)",\
									 "Hacking Malfunction(Battle)",\
									 "Lanius(Battle)",\
									 "Lost Ship(Battle)",\
									 "Slug(Battle)"))

	songs = list("side1" = list("voidcrew/sound/music/walkman/ftl/3-1-1.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-2.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-3.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-4.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-5.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-6.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-7.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-8.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-9.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-10.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-11.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-12.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-13.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-14.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-15.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-16.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-1-17.ogg"),

				 "side2" = list("voidcrew/sound/music/walkman/ftl/3-2-1.ogg",\
				 				"voidcrew/sound/music/walkman/ftl/3-2-2.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-2-3.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-2-4.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-2-5.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-2-6.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-2-7.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-2-8.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-2-9.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-2-10.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-2-11.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-2-12.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-2-13.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-2-14.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-2-15.ogg",\
								"voidcrew/sound/music/walkman/ftl/3-2-16.ogg"))

/obj/item/device/cassette_tape/ftl
	tape = /datum/cassette/cassette_tape/ftl

/datum/cassette/cassette_tape/friday
	name = " A Millions Miles Away"
	desc = "A stylized plastic cassette tape with a synthwave asethetic."
	icon_state = "cassette_friday"
	side1_icon = "cassette_friday"
	side2_icon = "cassette_friday"
	id = 4
	song_names = list("side1" = list("Now and Forever",\
									 "Horsey",\
									 "This Feeling",\
									 "Lovers",\
									 "Night In Tokyo Pt. II"),
					  "side2" = list("Grandlife, Highlife",\
					  				 "82.99 F.M.",\
									 "Fugaz",\
									 "アスカBad Girl",\
									 "Thank You"))

	songs = list("side1" = list("voidcrew/sound/music/walkman/friday/4-1-1.ogg",\
								"voidcrew/sound/music/walkman/friday/4-1-2.ogg",\
								"voidcrew/sound/music/walkman/friday/4-1-3.ogg",\
								"voidcrew/sound/music/walkman/friday/4-1-4.ogg",\
								"voidcrew/sound/music/walkman/friday/4-1-5.ogg"),
				 "side2" = list("voidcrew/sound/music/walkman/friday/4-2-1.ogg",\
				 				"voidcrew/sound/music/walkman/friday/4-2-2.ogg",\
								"voidcrew/sound/music/walkman/friday/4-2-3.ogg",\
								"voidcrew/sound/music/walkman/friday/4-2-4.ogg",\
								"voidcrew/sound/music/walkman/friday/4-2-5.ogg"))

/obj/item/device/cassette_tape/friday
	tape = /datum/cassette/cassette_tape/friday
