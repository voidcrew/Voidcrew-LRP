//Overwrite world/New() to setup some VoidCrew specific stuff
/world/New()
	. = ..()


	// Load IPC species datums
	make_ipc_datum_references_list()
