/obj/item/gun/ballistic/automatic/solar
	name = "SolGov assault rifle"
	desc = "The end result of 12 years of work by SolarGarrison's R&D division. Chambered in 4.73×33mm caseless ammunition."
	icon = 'voidcrew/icons/obj/guns/projectile.dmi'
	icon_state = "solar"
	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	item_state = "arg"
	mag_type = /obj/item/ammo_box/magazine/rifle47x33mm
	can_suppress = FALSE
	fire_rate = 5
	actions_types = list()
	can_bayonet = FALSE
	mag_display = TRUE
	w_class = WEIGHT_CLASS_BULKY

/obj/item/gun/ballistic/automatic/pistol/commander
	name = "\improper Commander"
	desc = "A modification on the classic 1911 handgun, this one is chambered in 9mm. Much like its predecessor, it suffers from low capacity."
	icon = 'voidcrew/icons/obj/guns/projectile.dmi'
	icon_state = "commander"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/co9mm
	can_suppress = FALSE
/obj/item/gun/ballistic/automatic/pistol/commander/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/solgov
	name = "SolGov M9C"
	desc = "Known formally as the M9A5C, this is a compact caseless ammo handgun made for switching to when your primary runs empty on it's mag."
	icon = 'voidcrew/icons/obj/guns/projectile.dmi'
	icon_state = "solm9c"
	weapon_weight = WEAPON_LIGHT
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/pistol556mm

/obj/item/gun/ballistic/automatic/aks74u
	name = "AKS-74U"
	desc = "A pre-FTL era carbine, the \"curio\" status of the weapon and its relative cheap cost to manufacture make it perfect for bandits, pirates and colonists on a budget."
	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	icon = 'voidcrew/icons/obj/guns/projectile.dmi'
	icon_state = "aks74u"
	fire_rate = 10
	lefthand_file = 'voidcrew/icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'voidcrew/icons/mob/inhands/weapons/64x_guns_right.dmi'
	item_state = "aks74u"
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/aks74u

/obj/item/gun/ballistic/automatic/ak47
	name = "AK-47"
	desc = "An old assault rifle, dating back to 20th century. It is commonly used by various bandits, pirates and colonists thanks to its reliability and ease of maintenance."
	icon = 'voidcrew/icons/obj/guns/48x32guns.dmi'
	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	lefthand_file = 'voidcrew/icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'voidcrew/icons/mob/inhands/weapons/64x_guns_right.dmi'
	icon_state = "ak47"
	item_state = "ak47"
	fire_rate = 5
	mag_display = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/ak47

/obj/item/gun/ballistic/automatic/ak47/nt
	name = "NT-AK"
	desc = "A cheap rip-off of an already cheap rifle. Comes with a foldable stock for easy storage, although accuracy is questionable when folded. Control click to toggle the stock."
	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	icon_state = "ak47_nt"
	item_state = "ntak"
	fire_rate = 5
	mag_display = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/aknt
	var/folded = FALSE
	var/unfolded_spread = 2
	var/unfolded_recoil = 0
	var/folded_spread = 7
	var/folded_recoil = 0.50

/obj/item/gun/ballistic/automatic/ak47/nt/CtrlClick(mob/user)
	. = ..()
	if((!ishuman(user) || user.stat))
		return
	fold(user)

/obj/item/gun/ballistic/automatic/ak47/nt/proc/fold(mob/user)
	if(folded)
		to_chat(user, "<span class='notice'>You unfold the stock on the [src].</span>")
		spread = unfolded_spread
		recoil = unfolded_recoil
		w_class = WEIGHT_CLASS_BULKY
	else
		to_chat(user, "<span class='notice'>You fold the stock on the [src].</span>")
		spread = folded_spread
		recoil = folded_recoil
		w_class = WEIGHT_CLASS_NORMAL

	folded = !folded
	playsound(src.loc, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()

/obj/item/gun/ballistic/automatic/ak47/nt/update_overlays()
	. = ..()
	var/mutable_appearance/stock
	if(!folded)
		stock = mutable_appearance(icon, "ak47_nt_stock")
	else
		stock = mutable_appearance(icon, null)
	. += stock

/obj/item/gun/ballistic/automatic/pistol/tec9
	name = "TEC9 Machine Pistol"
	desc = "A new take on an old classic, firing 9mm rounds at unprecedented firerates. Perfect for gatting people down, especially considering how plentiful ammo is."
	icon = 'voidcrew/icons/obj/guns/projectile.dmi'
	icon_state = "tec9"
	weapon_weight = WEAPON_LIGHT
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/tec9
	fire_rate = 6
	automatic = 1
	mag_display = TRUE

/obj/item/gun/ballistic/automatic/ebr
	name = "\improper M514 EBR"
	desc = {"A cheap, reliable rifle often found in the hands of low-ranking Syndicate personnel. It's known for rather high stopping power and mild armor-piercing capabilities."}
	icon = 'voidcrew/icons/obj/guns/48x32guns.dmi'
	lefthand_file = 'voidcrew/icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'voidcrew/icons/mob/inhands/weapons/64x_guns_right.dmi'
	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	icon_state = "ebr"
	item_state = "ebr"
	fire_rate = 2
	mag_display = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/ebr


/obj/item/gun/ballistic/automatic/vector
	name = "Vector Carbine"
	desc = "A police carbine based off of an SMG design, with most of the complex workings removed for reliability. Chambered in 9mm."
	icon = 'voidcrew/icons/obj/guns/projectile.dmi'
	lefthand_file = 'voidcrew/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'voidcrew/icons/mob/inhands/weapons/guns_righthand.dmi'
	icon_state = "vector"
	item_state = "vector"
	mag_type = /obj/item/ammo_box/magazine/smgm9mm/rubbershot //you guys remember when the autorifle was chambered in 9mm
	bolt_type = BOLT_TYPE_LOCKING
	mag_display = TRUE
	weapon_weight = WEAPON_LIGHT
	fire_rate = 4

/obj/item/gun/ballistic/automatic/zip_pistol
	name = "Makeshift Pistol"
	desc = "A makeshift janky pistol, its a miracle it even works."
	icon = 'voidcrew/icons/obj/guns/projectile.dmi'
	lefthand_file = 'voidcrew/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'voidcrew/icons/mob/inhands/weapons/guns_righthand.dmi'
	icon_state = "ZipPistol"
	item_state = "ZipPistol"
	mag_type = /obj/item/ammo_box/magazine/zip_ammo_9mm
	can_suppress = FALSE
	actions_types = list()
	can_bayonet = FALSE
	mag_display = TRUE
	weapon_weight = WEAPON_LIGHT
	fire_rate = 3
