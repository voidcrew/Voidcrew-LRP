/obj/effect/countdown/clonepod
	name = "cloning pod countdown"
	color = "#18d100"
	text_size = 1

/obj/effect/countdown/clonepod/get_value()
	var/obj/machinery/clonepod/attacked_clone_pod = attached_to
	if(!istype(attacked_clone_pod))
		return
	if(attacked_clone_pod.occupant)
		var/completion = round(attacked_clone_pod.get_completion())
		return completion
