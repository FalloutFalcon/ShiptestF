// Basic ladder. By default links to the z-level above/below.
/obj/structure/ladder
	name = "ladder"
	desc = "A sturdy metal ladder."
	icon = 'icons/obj/structures.dmi'
	icon_state = "ladder11"
	anchored = TRUE
	var/obj/structure/ladder/down   //the ladder below this one
	var/obj/structure/ladder/up     //the ladder above this one
	var/crafted = FALSE
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN

/obj/structure/ladder/Initialize(mapload, obj/structure/ladder/up, obj/structure/ladder/down)
	..()
	if (up)
		src.up = up
		up.down = src
		up.update_appearance()
	if (down)
		src.down = down
		down.up = src
		down.update_appearance()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/ladder/Destroy(force)
	if ((resistance_flags & INDESTRUCTIBLE) && !force)
		return QDEL_HINT_LETMELIVE
	disconnect()
	return ..()

/obj/structure/ladder/LateInitialize()
	// By default, discover ladders above and below us vertically
	var/turf/T = get_turf(src)
	var/obj/structure/ladder/L

	if (!down)
		L = locate() in T.below()
		if (L)
			if(crafted == L.crafted)
				down = L
				L.up = src  // Don't waste effort looping the other way
				L.update_appearance()
	if (!up)
		L = locate() in T.above()
		if (L)
			if(crafted == L.crafted)
				up = L
				L.down = src  // Don't waste effort looping the other way
				L.update_appearance()

	update_appearance()

/obj/structure/ladder/proc/disconnect()
	if(up && up.down == src)
		up.down = null
		up.update_appearance()
	if(down && down.up == src)
		down.up = null
		down.update_appearance()
	up = down = null

/obj/structure/ladder/update_icon_state()
	icon_state = "ladder[up ? 1 : 0][down ? 1 : 0]"
	return ..()


/obj/structure/ladder/singularity_pull()
	if (!(resistance_flags & INDESTRUCTIBLE))
		visible_message(span_danger("[src] is torn to pieces by the gravitational pull!"))
		qdel(src)

/obj/structure/ladder/proc/travel(going_up, mob/user, is_ghost, obj/structure/ladder/ladder)
	if(!is_ghost)
		show_fluff_message(going_up, user)
		ladder.add_fingerprint(user)

	var/turf/T = get_turf(ladder)
	var/atom/movable/AM
	if(user.pulling)
		AM = user.pulling
		AM.forceMove(T)
	user.forceMove(T)
	if(AM)
		user.start_pulling(AM)

/obj/structure/ladder/proc/use(mob/user, is_ghost=FALSE)
	if (!is_ghost && !in_range(src, user))
		return

	var/list/tool_list = list(
		"Up" = image(icon = 'icons/testing/turf_analysis.dmi', icon_state = "red_arrow", dir = NORTH),
		"Down" = image(icon = 'icons/testing/turf_analysis.dmi', icon_state = "red_arrow", dir = SOUTH)
		)

	if (up && down)
		var/result = show_radial_menu(user, src, tool_list, custom_check = CALLBACK(src, PROC_REF(check_menu), user), require_near = TRUE, tooltips = TRUE)
		if (!is_ghost && !in_range(src, user))
			return  // nice try
		switch(result)
			if("Up")
				travel(TRUE, user, is_ghost, up)
			if("Down")
				travel(FALSE, user, is_ghost, down)
			if("Cancel")
				return
	else if(up)
		travel(TRUE, user, is_ghost, up)
	else if(down)
		travel(FALSE, user, is_ghost, down)
	else
		to_chat(user, span_warning("[src] doesn't seem to lead anywhere!"))

	if(!is_ghost)
		add_fingerprint(user)

/obj/structure/ladder/proc/check_menu(mob/user)
	if(user.incapacitated() || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/structure/ladder/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	use(user)

/obj/structure/ladder/attack_paw(mob/user)
	return use(user)

/obj/structure/ladder/attackby(obj/item/W, mob/user, params)
	return use(user)

/obj/structure/ladder/attack_robot(mob/living/silicon/robot/R)
	if(R.Adjacent(src))
		return use(R)

//ATTACK GHOST IGNORING PARENT RETURN VALUE
/obj/structure/ladder/attack_ghost(mob/dead/observer/user)
	use(user, TRUE)
	return ..()

/obj/structure/ladder/proc/show_fluff_message(going_up, mob/user)
	if(going_up)
		user.visible_message(span_notice("[user] climbs up [src]."), span_notice("You climb up [src]."))
	else
		user.visible_message(span_notice("[user] climbs down [src]."), span_notice("You climb down [src]."))


// Indestructible away mission ladders which link based on a mapped ID and height value rather than X/Y/Z.
/obj/structure/ladder/unbreakable
	name = "sturdy ladder"
	desc = "An extremely sturdy metal ladder."
	resistance_flags = INDESTRUCTIBLE
	var/id
	var/height = 0  // higher numbers are considered physically higher

/obj/structure/ladder/unbreakable/Initialize()
	GLOB.ladders += src
	return ..()

/obj/structure/ladder/unbreakable/Destroy()
	. = ..()
	if (. != QDEL_HINT_LETMELIVE)
		GLOB.ladders -= src

/obj/structure/ladder/unbreakable/LateInitialize()
	// Override the parent to find ladders based on being height-linked
	if (!id || (up && down))
		update_appearance()
		return

	for (var/O in GLOB.ladders)
		var/obj/structure/ladder/unbreakable/L = O
		if (L.id != id)
			continue  // not one of our pals
		if (!down && L.height == height - 1)
			down = L
			L.up = src
			L.update_appearance()
			if (up)
				break  // break if both our connections are filled
		else if (!up && L.height == height + 1)
			up = L
			L.down = src
			L.update_appearance()
			if (down)
				break  // break if both our connections are filled

	update_appearance()

/obj/structure/ladder/crafted
	crafted = TRUE
