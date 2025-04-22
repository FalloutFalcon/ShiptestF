// Clickable stat() button.
/obj/effect/statclick
	name = "Initializing..."
	var/target

INITIALIZE_IMMEDIATE(/obj/effect/statclick)

/obj/effect/statclick/Initialize(mapload, text, target) //Don't port this to Initialize it's too critical
	. = ..()
	name = text
	src.target = target

/obj/effect/statclick/proc/update(text)
	name = text
	return src

/obj/effect/statclick/debug
	var/class

/obj/effect/statclick/debug/Click()
	if(!usr.client.holder || !target)
		return
	if(!class)
		if(istype(target, /datum/controller/subsystem))
			class = "subsystem"
		else if(istype(target, /datum/controller))
			class = "controller"
		else if(istype(target, /datum))
			class = "datum"
		else
			class = "unknown"

	usr.client.debug_variables(target)
	message_admins("Admin [key_name_admin(usr)] is debugging the [target] [class].")

ADMIN_VERB(restart_controller, R_DEBUG, "Restart Controller", "Restart one of the various periodic loop controllers for the game (be careful!)", ADMIN_CATEGORY_DEBUG, controller in list("Master", "Failsafe"))
	switch(controller)
		if("Master")
			Recreate_MC()
			BLACKBOX_LOG_ADMIN_VERB("Restart Master Controller")
		if("Failsafe")
			new /datum/controller/failsafe()
			BLACKBOX_LOG_ADMIN_VERB("Restart Failsafe Controller")

	message_admins("Admin [key_name_admin(usr)] has restarted the [controller] controller.")
