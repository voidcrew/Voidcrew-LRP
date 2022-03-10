/obj/item/organ/ears/robot
	name = "auditory sensors"
	icon = 'voidcrew/icons/obj/surgery.dmi'
	icon_state = "robotic_ears"
	desc = "A pair of microphones intended to be installed in an IPC head, that grant the ability to hear."
	zone = "head"
	slot = "ears"
	gender = PLURAL
	status = ORGAN_ROBOTIC

/obj/item/organ/ears/robot/emp_act(severity)
	switch(severity)
		if(1)
			owner.Jitter(30)
			owner.Dizzy(30)
			owner.Knockdown(200)
			deaf = 30
			to_chat(owner, "<span class='warning'>Your robotic ears are ringing, uselessly.</span>")
		if(2)
			owner.Jitter(15)
			owner.Dizzy(15)
			owner.Knockdown(100)
			to_chat(owner, "<span class='warning'>Your robotic ears buzz.</span>")
