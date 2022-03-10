/obj/machinery/vending/security/wall
	name = "\improper SecTech Lite"
	desc = "A wall mounted security equipment vendor."
	icon_state = "wallsec"
	icon_deny = "wallsec-deny"
	light_mask = "wallsec-light-mask"
	refill_canister = /obj/item/vending_refill/wallsec
	density = FALSE
	tiltable = FALSE
	products = list(
		/obj/item/restraints/handcuffs = 5,
		/obj/item/restraints/handcuffs/cable/zipties = 10,
		/obj/item/stock_parts/cell = 3,
		)
	contraband = list()
	premium = list()

/obj/item/vending_refill/wallsec
	icon_state = "refill_sec"

/obj/machinery/vending/security/marine
	name = "\improper marine vendor"
	desc = "A marine equipment vendor."
	product_ads = "Please insert your marine voucher in the bottom slot."
	icon_state = "syndicate-marine"
	icon_deny = "syndicate-marine-deny"
	light_mask = "syndicate-marine-mask"
	icon_vend = "syndicate-marine-vend"
	req_access = list(ACCESS_SYNDICATE)
	products = list(
		/obj/item/restraints/handcuffs = 3,
		/obj/item/assembly/flash/handheld = 2,
		/obj/item/flashlight/seclite = 2,
		/obj/item/ammo_box/magazine/m10mm = 3,
		/obj/item/ammo_box/magazine/smgm45 = 3,
		/obj/item/ammo_box/magazine/sniper_rounds = 3,
		/obj/item/ammo_box/magazine/m556 = 2,
		/obj/item/ammo_box/magazine/m12g = 3,
		/obj/item/ammo_box/magazine/ebr = 5,
		/obj/item/grenade/c4 = 1,
		/obj/item/grenade/frag = 1,
		/obj/item/melee/energy/sword/saber/red = 1,
		)
	contraband = list()
	premium = list()

/obj/machinery/vending/security/marine/solgov
	icon_state = "solgov-marine"
	icon_deny = "solgov-marine-deny"
	light_mask = "solgov-marine-mask"
	icon_vend = "solgov-marine-vend"
	req_access = list(ACCESS_SECURITY)
	products = list(
		/obj/item/restraints/handcuffs = 10,
		/obj/item/assembly/flash/handheld = 10,
		/obj/item/flashlight/seclite = 10,
		/obj/item/reagent_containers/hypospray/combat = 1,
		/obj/item/ammo_box/magazine/rifle47x33mm = 5,
		/obj/item/ammo_box/magazine/pistol556mm = 10,
		/obj/item/stock_parts/cell = 10,
		/obj/item/screwdriver/nuke = 5,
		/obj/item/grenade/c4 = 5,
		/obj/item/grenade/frag = 5,
		/obj/item/grenade/flashbang = 5,
		/obj/item/grenade/barrier = 10,
		/obj/item/melee/energy/sword/saber/red = 1,
		)

/obj/item/gun_voucher
	name = "security weapon voucher"
	desc = "A token used to redeem guns from the SecTech vendor."
	icon = 'icons/obj/vending.dmi'
	icon_state = "sec-voucher"
	w_class = WEIGHT_CLASS_TINY

/obj/item/gun_voucher/solgov
	name = "solgov weapon voucher"
	desc = "A token used to redeem equipment from your nearest marine vendor."
	icon_state = "solgov-voucher"

/obj/item/gun_voucher/syndicate
	name = "syndicate weapon voucher"
	desc = "A token used to redeem equipment from your nearest marine vendor."
	icon_state = "syndie-voucher"
