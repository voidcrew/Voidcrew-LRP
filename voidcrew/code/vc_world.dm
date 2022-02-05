//Overwrite world/New() to setup some VoidCrew specific stuff
/world/New()
	. = ..()


	// Load custom species datums
	make_ipc_datum_references_list()
	make_kepori_datum_references_list()
	make_squid_datum_references_list()

	// Load all mentors
	load_mentors()
