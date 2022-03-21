/obj/structure/closet/secure_closet/lieutenant
	name = "SolGov official's locker"
	req_access = list(ACCESS_CENT_CAPTAIN)
	icon_state = "solgov"

/obj/structure/closet/secure_closet/lieutenant/PopulateContents()
	..()
	new /obj/item/clothing/head/beret/solgov(src)
	new /obj/item/storage/briefcase(src)
	new	/obj/item/storage/firstaid/regular(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/suit/armor/vest/solgov/rep(src)
	new /obj/item/clothing/suit/solgov_trenchcoat(src)
	new /obj/item/clothing/accessory/waistcoat/solgov(src)
	new /obj/item/clothing/shoes/laceup(src)

