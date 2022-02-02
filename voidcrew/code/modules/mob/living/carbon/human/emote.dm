/datum/emote/living/carbon/human/scream/get_sound(mob/living/user)
	. = ..()
	if (!ishuman(user))
		return
	var/mob/living/carbon/human/squid = user
	if(squid.mind?.miming)
		return
	if(issquidperson(squid))
		return 'voidcrew/sound/voice/squid/squidscream.ogg'
