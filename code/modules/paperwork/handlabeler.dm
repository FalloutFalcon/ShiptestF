/obj/item/hand_labeler
	name = "hand labeler"
	desc = "A combined label printer, applicator, and remover, all in a single portable device. Designed to be easy to operate and use."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "labeler0"
	item_state = "flight"
	w_class = WEIGHT_CLASS_SMALL
	var/label = null
	var/labels_left = 30
	var/mode = 0

/obj/item/hand_labeler/afterattack(atom/A, mob/user,proximity)
	. = ..()
	if(!proximity)
		return
	if(!mode)	//if it's off, give up.
		return

	if(!labels_left)
		to_chat(user, span_warning("No labels left!"))
		return
	if(!label || !length(label))
		to_chat(user, span_warning("No text set!"))
		return
	if(length(A.name) + length(label) > 64)
		to_chat(user, span_warning("Label too big!"))
		return
	if(ismob(A))
		to_chat(user, span_warning("You can't label creatures!")) // use a collar
		return

	user.visible_message(
		span_notice("[user] labels [A] with \"[label]\"."), \
		span_notice("You label [A] with \"[label]\"."))
	A.AddComponent(/datum/component/label, label)
	playsound(A, 'sound/items/handling/component_pickup.ogg', 20, TRUE)
	labels_left--


/obj/item/hand_labeler/attack_self(mob/user)
	if(!user.IsAdvancedToolUser())
		to_chat(user, span_warning("You don't have the dexterity to use [src]!"))
		return
	mode = !mode
	icon_state = "labeler[mode]"
	if(mode)
		to_chat(user, span_notice("You turn on [src]."))
		//Now let them chose the text.
		var/str = reject_bad_text(stripped_input(user, "Label text?", "Set label","", MAX_NAME_LEN))
		if(!str || !length(str))
			to_chat(user, span_warning("Invalid text!"))
			return
		label = str
		to_chat(user, span_notice("You set the text to '[str]'."))
	else
		to_chat(user, span_notice("You turn off [src]."))

/obj/item/hand_labeler/attackby(obj/item/I, mob/user, params)
	..()
	if(istype(I, /obj/item/hand_labeler_refill))
		to_chat(user, span_notice("You insert [I] into [src]."))
		qdel(I)
		labels_left = initial(labels_left)	//Yes, it's capped at its initial value

/obj/item/hand_labeler/borg
	name = "cyborg-hand labeler"

/obj/item/hand_labeler/borg/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!iscyborg(user))
		return

	var/mob/living/silicon/robot/borgy = user

	var/starting_labels = initial(labels_left)
	var/diff = starting_labels - labels_left
	if(diff)
		labels_left = starting_labels
		// 50 per label. Magical cyborg paper doesn't come cheap.
		var/cost = diff * 50

		// If the cyborg manages to use a module without a cell, they get the paper
		// for free.
		if(borgy.cell)
			borgy.cell.use(cost)

/obj/item/hand_labeler_refill
	name = "hand labeler paper roll"
	icon = 'icons/obj/bureaucracy.dmi'
	desc = "A roll of paper. Use it on a hand labeler to refill it."
	icon_state = "labeler_refill"
	item_state = "electropack"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
