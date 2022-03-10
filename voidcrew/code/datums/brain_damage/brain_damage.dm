/datum/brain_trauma
	///Will this transfer if the brain is cloned?
	var/clonable = TRUE

/datum/brain_trauma/proc/on_clone()
	if(clonable)
		return new type
