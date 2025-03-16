////////////////////////////////////////
/////////////Stock Parts////////////////
////////////////////////////////////////

/datum/design/RPED
	name = "Rapid Part Exchange Device"
	desc = "Special mechanical module made to store, sort, and apply standard machine parts."
	id = "rped"
	build_type = PROTOLATHE | AUTOLATHE
	build_path = /obj/item/storage/part_replacer
	departmental_flags = ALL
	materials = list(
		/datum/material/iron = 10000,
		/datum/material/glass = 5000,
		/datum/material/titanium = 5000,
	)
	category = list(
		"Stock Parts",
		"Imported",
	)

/datum/design/BS_RPED
	name = "Bluespace RPED"
	desc = "Powered by bluespace technology, this RPED variant can upgrade buildings from a distance, without needing to remove the panel first."
	id = "bs_rped"
	build_type = PROTOLATHE | AUTOLATHE
	build_path = /obj/item/storage/part_replacer/bluespace
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE
	materials = list(
		/datum/material/iron = 10000,
		/datum/material/glass = 5000,
		/datum/material/titanium = 5000,
		/datum/material/silver = 2500,
		/datum/material/bluespace = 2500,
	)
	category = list(
		"Stock Parts",
		"Imported",
	)

//Capacitors
/datum/design/basic_capacitor
	name = "Basic Capacitor"
	desc = "A stock part used in the construction of various devices."
	id = "basic_capacitor"
	build_type = PROTOLATHE | AUTOLATHE
	build_path = /obj/item/stock_parts/capacitor
	departmental_flags = ALL
	lathe_time_factor = 0.2
	materials = list(
		/datum/material/iron = 100,
		/datum/material/glass = 100,
	)
	category = list(
		"Stock Parts",
		"Machinery",
		"initial",
		"Imported",
	)

/datum/design/adv_capacitor
	name = "Advanced Capacitor"
	desc = "A stock part used in the construction of various devices."
	id = "adv_capacitor"
	build_type = PROTOLATHE | AUTOLATHE
	build_path = /obj/item/stock_parts/capacitor/adv
	lathe_time_factor = 0.2
	departmental_flags = ALL
	materials = list(
		/datum/material/iron = 150,
		/datum/material/glass = 150,
	)
	category = list(
		"Stock Parts",
		"Imported",
	)

/datum/design/super_capacitor
	name = "Super Capacitor"
	desc = "A stock part used in the construction of various devices."
	id = "super_capacitor"
	build_type = PROTOLATHE | AUTOLATHE
	build_path = /obj/item/stock_parts/capacitor/super
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE
	materials = list(
		/datum/material/iron = 200,
		/datum/material/glass = 200,
		/datum/material/gold = 100,
	)
	category = list(
		"Stock Parts",
		"Imported",
	)

/datum/design/quadratic_capacitor //todo: maybe make autolathes capable of using bluespace crystals
	name = "Quadratic Capacitor"
	desc = "A stock part used in the construction of various devices."
	id = "quadratic_capacitor"
	build_type = PROTOLATHE | AUTOLATHE
	build_path = /obj/item/stock_parts/capacitor/quadratic
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE
	materials = list(
		/datum/material/iron = 200,
		/datum/material/glass = 200,
		/datum/material/gold = 100,
		/datum/material/diamond = 100,
		/datum/material/bluespace = 50,

	)
	category = list(
		"Stock Parts",
	)

//Scanning modules
/datum/design/basic_scanning
	name = "Basic Scanning Module"
	desc = "A stock part used in the construction of various devices."
	id = "basic_scanning"
	build_type = PROTOLATHE | AUTOLATHE
	build_path = /obj/item/stock_parts/scanning_module
	lathe_time_factor = 0.2
	departmental_flags = ALL
	materials = list(
		/datum/material/iron = 100,
		/datum/material/glass = 100,
	)
	category = list(
		"Stock Parts",
		"Machinery",
		"initial",
		"Imported",
	)

/datum/design/adv_scanning
	name = "Advanced Scanning Module"
	desc = "A stock part used in the construction of various devices."
	id = "adv_scanning"
	build_type = PROTOLATHE | AUTOLATHE
	build_path = /obj/item/stock_parts/scanning_module/adv
	lathe_time_factor = 0.2
	departmental_flags = ALL
	materials = list(
		/datum/material/iron = 150,
		/datum/material/glass = 150,
	)
	category = list(
		"Stock Parts",
		"Imported",
	)

/datum/design/phasic_scanning
	name = "Phasic Scanning Module"
	desc = "A stock part used in the construction of various devices."
	id = "phasic_scanning"
	build_type = PROTOLATHE | AUTOLATHE
	build_path = /obj/item/stock_parts/scanning_module/phasic
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE
	materials = list(
		/datum/material/iron = 200,
		/datum/material/glass = 200,
		/datum/material/silver = 50,
	)

	category = list(
		"Stock Parts",
		"Imported",
	)

/datum/design/triphasic_scanning
	name = "Triphasic Scanning Module"
	desc = "A stock part used in the construction of various devices."
	id = "triphasic_scanning"
	build_type = PROTOLATHE | AUTOLATHE
	build_path = /obj/item/stock_parts/scanning_module/triphasic
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE
	materials = list(
		/datum/material/iron = 200,
		/datum/material/glass = 200,
		/datum/material/silver = 50,
		/datum/material/diamond = 50,
		/datum/material/bluespace = 50,
	)
	category = list(
		"Stock Parts",
		"Imported",
	)

//Maipulators
/datum/design/micro_mani
	name = "Micro Manipulator"
	desc = "A stock part used in the construction of various devices."
	id = "micro_mani"
	build_type = PROTOLATHE | AUTOLATHE
	build_path = /obj/item/stock_parts/manipulator
	lathe_time_factor = 0.2
	departmental_flags = ALL
	materials = list(
		/datum/material/iron = 100,
	)
	category = list(
		"Stock Parts",
		"Machinery",
		"initial",
		"Imported",
	)

/datum/design/nano_mani
	name = "Nano Manipulator"
	desc = "A stock part used in the construction of various devices."
	id = "nano_mani"
	build_type = PROTOLATHE | AUTOLATHE
	build_path = /obj/item/stock_parts/manipulator/nano
	lathe_time_factor = 0.2
	departmental_flags = ALL
	materials = list(
		/datum/material/iron = 150,
		/datum/material/glass = 150,
	)
	category = list(
		"Stock Parts",
		"Imported",
	)

/datum/design/pico_mani
	name = "Pico Manipulator"
	desc = "A stock part used in the construction of various devices."
	id = "pico_mani"
	build_type = PROTOLATHE | AUTOLATHE
	build_path = /obj/item/stock_parts/manipulator/pico
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE
	materials = list(
		/datum/material/iron = 200,
		/datum/material/glass = 200,
		/datum/material/titanium = 50,
	)
	category = list(
		"Stock Parts",
		"Imported",
	)

/datum/design/femto_mani
	name = "Femto Manipulator"
	desc = "A stock part used in the construction of various devices."
	id = "femto_mani"
	build_type = PROTOLATHE | AUTOLATHE
	build_path = /obj/item/stock_parts/manipulator/femto
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE
	materials = list(
		/datum/material/iron = 150,
		/datum/material/glass = 150,
		/datum/material/titanium = 50,
		/datum/material/diamond = 50,
		/datum/material/bluespace = 50,
	)
	category = list(
		"Stock Parts",
		"Imported",
	)

//Micro-lasers
/datum/design/basic_micro_laser
	name = "Basic Micro-Laser"
	desc = "A stock part used in the construction of various devices."
	id = "basic_micro_laser"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/glass = 50)
	build_path = /obj/item/stock_parts/micro_laser
	category = list("Stock Parts","Machinery","initial")
	lathe_time_factor = 0.2
	departmental_flags = ALL

/datum/design/high_micro_laser
	name = "High-Power Micro-Laser"
	desc = "A stock part used in the construction of various devices."
	id = "high_micro_laser"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 150, /datum/material/glass = 100)
	build_path = /obj/item/stock_parts/micro_laser/high
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = ALL

/datum/design/ultra_micro_laser
	name = "Ultra-High-Power Micro-Laser"
	desc = "A stock part used in the construction of various devices."
	id = "ultra_micro_laser"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 150, /datum/material/uranium = 60)
	build_path = /obj/item/stock_parts/micro_laser/ultra
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/quadultra_micro_laser
	name = "Quad-Ultra Micro-Laser"
	desc = "A stock part used in the construction of various devices."
	id = "quadultra_micro_laser"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 200, /datum/material/uranium = 100, /datum/material/diamond = 60)
	build_path = /obj/item/stock_parts/micro_laser/quadultra
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/basic_matter_bin
	name = "Basic Matter Bin"
	desc = "A stock part used in the construction of various devices."
	id = "basic_matter_bin"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 100)
	build_path = /obj/item/stock_parts/matter_bin
	category = list("Stock Parts","Machinery","initial")
	lathe_time_factor = 0.2
	departmental_flags = ALL

/datum/design/adv_matter_bin
	name = "Advanced Matter Bin"
	desc = "A stock part used in the construction of various devices."
	id = "adv_matter_bin"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 150)
	build_path = /obj/item/stock_parts/matter_bin/adv
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = ALL

/datum/design/super_matter_bin
	name = "Super Matter Bin"
	desc = "A stock part used in the construction of various devices."
	id = "super_matter_bin"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200)
	build_path = /obj/item/stock_parts/matter_bin/super
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/bluespace_matter_bin
	name = "Bluespace Matter Bin"
	desc = "A stock part used in the construction of various devices."
	id = "bluespace_matter_bin"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 250, /datum/material/diamond = 100, /datum/material/bluespace = 100)
	build_path = /obj/item/stock_parts/matter_bin/bluespace
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

//T-Comms devices
/datum/design/subspace_ansible
	name = "Subspace Ansible"
	desc = "A compact module capable of sensing extradimensional activity."
	id = "s-ansible"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/silver = 100)
	build_path = /obj/item/stock_parts/subspace/ansible
	category = list("Stock Parts")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/hyperwave_filter
	name = "Hyperwave Filter"
	desc = "A tiny device capable of filtering and converting super-intense radiowaves."
	id = "s-filter"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/silver = 100)
	build_path = /obj/item/stock_parts/subspace/filter
	category = list("Stock Parts")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/subspace_amplifier
	name = "Subspace Amplifier"
	desc = "A compact micro-machine capable of amplifying weak subspace transmissions."
	id = "s-amplifier"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/gold = 100, /datum/material/uranium = 100)
	build_path = /obj/item/stock_parts/subspace/amplifier
	category = list("Stock Parts")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/subspace_treatment
	name = "Subspace Treatment Disk"
	desc = "A compact micro-machine capable of stretching out hyper-compressed radio waves."
	id = "s-treatment"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/silver = 200)
	build_path = /obj/item/stock_parts/subspace/treatment
	category = list("Stock Parts")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/subspace_analyzer
	name = "Subspace Analyzer"
	desc = "A sophisticated analyzer capable of analyzing cryptic subspace wavelengths."
	id = "s-analyzer"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/gold = 100)
	build_path = /obj/item/stock_parts/subspace/analyzer
	category = list("Stock Parts")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/subspace_crystal
	name = "Ansible Crystal"
	desc = "A sophisticated analyzer capable of analyzing cryptic subspace wavelengths."
	id = "s-crystal"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/glass = 800, /datum/material/silver = 100, /datum/material/gold = 100)
	build_path = /obj/item/stock_parts/subspace/crystal
	category = list("Stock Parts")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/subspace_transmitter
	name = "Subspace Transmitter"
	desc = "A large piece of equipment used to open a window into the subspace dimension."
	id = "s-transmitter"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/glass = 100, /datum/material/silver = 100, /datum/material/uranium = 100)
	build_path = /obj/item/stock_parts/subspace/transmitter
	category = list("Stock Parts")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/card_reader
	name = "Card Reader"
	desc = "A small magnetic card reader, used for devices that take and transmit holocredits."
	id = "c-reader"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron=50, /datum/material/glass=10)
	build_path = /obj/item/stock_parts/card_reader
	category = list("Stock Parts")
