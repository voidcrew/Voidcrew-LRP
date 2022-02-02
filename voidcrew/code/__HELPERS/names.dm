/proc/kepori_name()
	var/name = "[pick(list("Fa", "Fe", "Fi", "Ma", "Me", "Mi", "Na", "Ne", "Ni", "Sa", "Se", "Si", "Ta", "Te", "Ti"))]"
	return name + "[pick(list("fa", "fe", "fi", "la", "le", "li", "ma", "me", "mi", "na", "ne", "ni", "ra", "re", "ri", "sa", "se", "si", "sha", "she", "shi", "ta", "te", "ti",))]" + "[pick(list("ca", "ce", "ci", "fa", "fe", "fi", "la", "le", "li", "ma", "me", "mi", "na", "ne", "ni", "ra", "re", "ri", "sa", "se", "si", "sha", "she", "shi", "ta", "te", "ti"))]"

/proc/squid_name()
	return "[pick(GLOB.squid_names)][pick("-", "", " ")][capitalize(pick(GLOB.squid_names) + pick(GLOB.squid_names))]"
