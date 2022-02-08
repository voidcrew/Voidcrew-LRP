/obj/item/radio/talk_into_impl(atom/movable/M, message, channel, list/spans, datum/language/language, list/message_mods)
	. = ..()
	playsound(src, "sound/effects/walkietalkie.ogg", 20, FALSE)
