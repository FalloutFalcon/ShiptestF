/obj/item/tool
	name = "tool"
	icon = 'icons/obj/tools.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT

/******************************
	/* Data and Checking */
*******************************/
/obj/item/proc/has_quality(quality_id)
	return !quality_id || (quality_id in tool_qualities)

/obj/item/proc/get_tool_quality(quality_id)
	if(tool_qualities && tool_qualities.len)
		return tool_qualities[quality_id]
	return null

//We are cheking if our item got required qualities. If we require several qualities, and item posses more than one of those, we ask user to choose how that item should be used
/obj/item/proc/get_tool_type(mob/living/user, list/required_qualities, atom/use_on, datum/callback/CB)
	if(!tool_qualities) //This is not a tool, or does not have tool qualities
		return

	var/list/L = required_qualities & tool_qualities

	if(L.len)
		if(L.len == 1)
			return L[1]
		for(var/i in L)
			#warn this is using eris tool sprites! FIX!!!!
			L[i] = image(icon = 'icons/hud/radial/tools.dmi', icon_state = i)
		return show_radial_menu(user, use_on ? use_on : user, L, tooltips = TRUE, require_near = TRUE, custom_check = CB)

/obj/item/tool/admin_debug
	name = "Electric Boogaloo 3000"
	icon_state = "multitool"
	item_state = "multitool"
	tool_qualities = list(
		QUALITY_BOLT_TURNING = 100,
		QUALITY_PRYING = 100,
		QUALITY_WELDING = 100,
		QUALITY_SCREW_DRIVING = 100,
		QUALITY_RETRACTING = 100,
		QUALITY_CAUTERIZING = 100,
		QUALITY_WIRE_CUTTING = 100,
		QUALITY_RETRACTING = 100,
		QUALITY_DRILLING = 100,
		QUALITY_SAWING = 100,
		QUALITY_VEIN_FIXING = 100,
		QUALITY_BONE_SETTING = 100,
		QUALITY_BONE_FIXING = 100,
		QUALITY_SHOVELING = 100,
		QUALITY_DIGGING = 100,
		QUALITY_EXCAVATION = 100,
		QUALITY_CUTTING = 100,
		QUALITY_HAMMERING = 100
	)
