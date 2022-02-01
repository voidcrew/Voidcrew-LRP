/obj/item/organ/brain/mmi_holder/posibrain/Initialize(mapload, obj/item/mmi/mmi)
	. = ..()
	if (!mmi || !istype(mmi))
		stored_mmi = new /obj/item/mmi/posibrain/ipc(src)
