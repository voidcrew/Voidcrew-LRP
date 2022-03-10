/obj/item/device/cassette_tape
	name = "cassette Tape"
	desc = "A cassette tape"
	icon = 'voidcrew/icons/obj/walkman.dmi'
	icon_state = "cassette_flip"
	w_class = WEIGHT_CLASS_SMALL
	//icon of the cassettes front side
	var/side1_icon = "cassette"
	//if the cassette is flipped, for playing second list of songs
	var/flipped = FALSE //Tape side
	//list of songs each side has to play
	var/list/songs = list()
	//the id of the cassette
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

/obj/item/device/cassette_tape/attackby(obj/item/item, mob/living/user)
	if(istype(item, /obj/item/pen))
		var/choice = input("What would you like to change?") in list("Cassette Name", "Cassette Description", "Cancel")
		switch(choice)
			if("Cassette Name")
				//the name we are giving the cassette
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
				//the description we are giving the cassette
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

/obj/item/device/cassette_tape/empty
	name = "blank cassette"
	id = 3
	desc = "A plastic cassette tape ."
	icon_state = "cassette_flip"
	side1_icon = "cassette_flip"
	songs = list("side1" = list(),
				 "side2" = list())

/obj/item/device/cassette_tape/ftl
	name = "Faster Than Light cassette"
	id = 4
	desc = "A plastic cassette tape with a ftl themed sticker."
	icon_state = "cassette_ftl"
	side1_icon = "cassette_ftl"
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

