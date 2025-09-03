/obj/item/clothing/shoes/sneakers
	name = "shoes"
	icon_state = "white"
	item_state = "white"
	icon = 'icons/obj/clothing/feet/color.dmi'
	mob_overlay_icon = 'icons/mob/clothing/feet/color.dmi'
	dying_key = DYE_REGISTRY_SNEAKERS
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION
	custom_price = 50
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT
	UNIQUE_RESKIN_HELPER("shoes")
	unique_reskin_changes_base_icon_state = TRUE
	unique_reskin_changes_name = TRUE

COLOR_VARIANTS_HELPER(shoes/sneakers, "shoes")

/obj/item/clothing/shoes/sneakers/white
	permeability_coefficient = 0.01

/obj/item/clothing/shoes/sneakers/orange

/obj/item/clothing/shoes/sneakers/orange/attack_self(mob/user)
	if (src.chained)
		src.chained = null
		src.slowdown = SHOES_SLOWDOWN
		new /obj/item/restraints/handcuffs(user.loc)
		src.icon_state = "orange"
	return

/obj/item/clothing/shoes/sneakers/orange/attackby(obj/H, loc, params)
	..()
	// Note: not using istype here because we want to ignore all subtypes
	if (H.type == /obj/item/restraints/handcuffs && !chained)
		qdel(H)
		src.chained = 1
		src.slowdown = 15
		src.icon_state = "orange1"
	return

/obj/item/clothing/shoes/sneakers/orange/allow_attack_hand_drop(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/C = user
		if(C.shoes == src && chained == 1)
			to_chat(user, span_warning("You need help taking these off!"))
			return FALSE
	return ..()

/obj/item/clothing/shoes/sneakers/orange/MouseDrop(atom/over)
	var/mob/m = usr
	if(ishuman(m))
		var/mob/living/carbon/human/c = m
		if(c.shoes == src && chained == 1)
			to_chat(c, span_warning("You need help taking these off!"))
			return
	return ..()

