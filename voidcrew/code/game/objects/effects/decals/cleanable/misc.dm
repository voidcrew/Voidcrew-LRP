/obj/effect/decal/cleanable/squid_ink
	name = "squid ink"
	desc = "A puddle of slippery squid ink."
	icon = 'icons/mob/robots.dmi'
	icon_state = "floor1"
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7")

/obj/effect/decal/cleanable/squid_ink/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/slippery, 5 SECONDS, NO_SLIP_WHEN_WALKING, CALLBACK(src, .proc/AfterSlip), 3 SECONDS)

/obj/effect/decal/cleanable/squid_ink/proc/AfterSlip(mob/living/mob)
	mob.AddComponent(/datum/component/outline)
	mob.playsound_local(get_turf(src), 'sound/effects/splat.ogg', 50, 1)
	mob.visible_message("<span class='warning'>[mob.name] gets covered in squid ink, leaving a hideous outline around them!</span>", "<span class='warning'>You get squid ink all over yourself, it's horrible!</span>")

