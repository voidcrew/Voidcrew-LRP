/obj/machinery/vending/security
	name = "\improper SecTech"
	desc = "A security equipment vendor."
	product_ads = "Crack capitalist skulls!;Beat some heads in!;Don't forget - harm is good!;Your weapons are right here.;Handcuffs!;Freeze, scumbag!;Don't tase me bro!;Tase them, bro.;Why not have a donut?"
	icon_state = "sec"
	icon_deny = "sec-deny"
	light_mask = "sec-light-mask"
	req_access = list(ACCESS_SECURITY)
	products = list(
		/obj/item/restraints/handcuffs = 8,
		/obj/item/restraints/handcuffs/cable/zipties = 10,
		/obj/item/assembly/flash/handheld = 5,
		/obj/item/storage/box/evidence = 6,
		/obj/item/flashlight/seclite = 4,
		/obj/item/ammo_box/c9mm/rubbershot = 3,
		/obj/item/ammo_box/c9mm = 1,
		/obj/item/stock_parts/cell/gun = 3)
	contraband = list(
		/obj/item/clothing/glasses/sunglasses = 2)
	premium = list(
		/obj/item/storage/belt/security/webbing = 5,
		/obj/item/coin/antagtoken = 1,
		/obj/item/clothing/head/helmet/blueshirt = 1,
		/obj/item/clothing/suit/armor/vest/blueshirt = 1,
		/obj/item/clothing/gloves/tackler = 5,
		/obj/item/grenade/stingbang = 1)
	refill_canister = /obj/item/vending_refill/security
	default_price = 650
	extra_price = 700
	payment_department = ACCOUNT_SEC

	var/voucher_items = list(
		"NT-E-Rifle" = /obj/item/gun/energy/e_gun,
		"E-TAR SMG" = /obj/item/gun/energy/e_gun/smg,
		"Vector SMG" = /obj/item/gun/ballistic/automatic/vector,
		"E-SG 500" = /obj/item/gun/energy/e_gun/iot)

/obj/machinery/vending/security/pre_throw(obj/item/I)
	if(istype(I, /obj/item/grenade))
		var/obj/item/grenade/G = I
		G.preprime()
	else if(istype(I, /obj/item/flashlight))
		var/obj/item/flashlight/F = I
		F.on = TRUE
		F.update_brightness()

/obj/item/vending_refill/security
	icon_state = "refill_sec"
