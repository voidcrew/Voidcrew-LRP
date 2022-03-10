/// VC WEAPONS TODO: Used in SolGov weapons. Pretty sure internal computers were removed on /tg/.
///obj/item/gun/energy/laser/iot/Initialize()
//	. = ..()
//	if(NTOS_type)
//		integratedNTOS = new NTOS_type(src)
//		integratedNTOS.physical = src
//
///obj/item/gun/energy/laser/iot/attack_self(mob/user)
//	. = ..()
//	if(!integratedNTOS)
//		return
//	integratedNTOS.interact(user)
