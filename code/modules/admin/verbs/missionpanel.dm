/datum/admins/proc/open_missionpanel()
	set category = "Event"
	set name = "Mission Manipulator"
	set desc = "Opens the mission manipulator UI."

	if(!check_rights(R_DEBUG))
		return

	SSmissions.ui_interact(usr)
