/proc/random_unique_kepori_name(attempts_to_find_unique_name = 10)
	for(var/_ in 1 to attempts_to_find_unique_name)
		. = capitalize(kepori_name())

		if(!findname(.))
			break

/proc/random_unique_squid_name(attempts_to_find_unique_name = 10)
	for(var/_ in 1 to attempts_to_find_unique_name)
		. = capitalize(squid_name())

		if(!findname(.))
			break
