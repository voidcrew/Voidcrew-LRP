/obj/item/gun/energy/pulse/terra
	name = "SolGov pulse rifle"
	desc = "An almost jury-rigged answer to NT's dominance on pulse weaponry. Features only 4 shots but can rapidly recharge."
	icon = 'voidcrew/icons/obj/guns/energy.dmi'
	icon_state = "terrapulse"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse)
	selfcharge = 1
	charge_delay = 0.5 //50 seconds to recharge the clip
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
