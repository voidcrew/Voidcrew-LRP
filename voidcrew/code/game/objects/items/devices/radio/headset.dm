/obj/item/radio/headset/solgov
	name = "\improper SolGov Offical's headset"
	desc = "A SolGov Official's headset."
	icon = 'voidcrew/icons/obj/radio.dmi'
	icon_state = "solgov_headset"
	keyslot = new /obj/item/encryptionkey/solgov

/obj/item/radio/headset/solgov/alt
	name = "\improper SolGov Officer's bowman headset"
	desc = "A SolGov Officer's headset. Protects ears from flashbangs."
	icon_state = "solgov_headset_alt"

/obj/item/radio/headset/solgov/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))
