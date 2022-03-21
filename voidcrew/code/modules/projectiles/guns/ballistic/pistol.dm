/obj/item/gun/ballistic/automatic/pistol/disposable
	name = "disposable gun"
	desc = "An exceedingly flimsy gun that is extremely cheap and easy to produce. You get what you pay for."
	icon_state = "disposable"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/disposable
	custom_materials = list(/datum/material/plastic=2000)
	can_suppress = FALSE
	var/random_icon = TRUE

/obj/item/gun/ballistic/automatic/pistol/disposable/Initialize()
	..()
	var/picked = pick("none","red","purple","yellow","green","dark")
	if(random_icon)
		if(picked == "none")
			return
		icon_state = "disposable_[picked]"

/obj/item/gun/ballistic/automatic/pistol/disposable/eject_magazine(mob/user)
	to_chat(user, "<span class='warning'>Theres no magazine to eject!</span>")
	return

/obj/item/gun/ballistic/automatic/pistol/disposable/insert_magazine(mob/user)
	to_chat(user, "<span class='warning'>Theres no magazine to replace!</span>")
	return

/obj/item/gun/ballistic/automatic/pistol/disposable/pizza
	name = "pizza disposable gun"
	desc = "How horrible. Whoever you point at with this won't be very cheesed to meet you." //this is a warcrime against itallians
	icon_state = "disposable_pizza"
	random_icon = FALSE
	custom_materials = list(/datum/material/pizza=2000)