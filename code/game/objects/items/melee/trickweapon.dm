/obj/item/melee/trick
	desc = "Hand crafted and highly desired weapons crafted and used by the SRM."
	icon = 'icons/obj/weapon/trick.dmi'

/obj/item/melee/trick/cleaving_saw
	name = "cleaving saw"
	desc = "This saw, effective at drawing the blood of beasts, transforms into a long cleaver that makes use of centrifugal force."
	force = 12
	var/active_force = 20 //force when active
	throwforce = 20
	var/active_throwforce = 20
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	icon_state = "cleaving_saw"
	item_state = "cleaving_saw"
	slot_flags = ITEM_SLOT_BELT
	attack_verb = list("attacked", "sawed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = IS_SHARP

	var/transform_cooldown
	var/swiping = FALSE
	var/bleed_stacks_per_hit = 3

/obj/item/melee/trick/cleaving_saw/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	AddComponent(/datum/component/butchering, 50, 100, 0, hitsound)
	AddComponent( \
		/datum/component/transforming, \
		transform_cooldown_time = (CLICK_CD_MELEE * 0.25), \
		force_on = active_force, \
		throwforce_on = active_throwforce, \
		attack_verb_on = list("cleave", "swipe", "slash", "chop"), \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/obj/item/melee/trick/cleaving_saw/examine(mob/user)
	. = ..()
	. += span_notice("It is [HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE) ? "open, will cleave enemies in a wide arc and deal additional damage to fauna":"closed, and can be used for rapid consecutive attacks that cause fauna to bleed"].")
	. += span_notice("Both modes will build up existing bleed effects, doing a burst of high damage if the bleed is built up high enough.")
	. += span_notice("Transforming it immediately after an attack causes the next attack to come out faster.")

/obj/item/melee/trick/cleaving_saw/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER
	user.changeNext_move(CLICK_CD_MELEE * 0.25)
	if(user)
		balloon_alert(user, "[active ? "opened" : "closed"] [src]")
	playsound(user, 'sound/magic/clockwork/fellowship_armory.ogg', 35, TRUE, frequency = 90000 - (active * 30000))
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/melee/trick/cleaving_saw/melee_attack_chain(mob/user, atom/target, params)
	. = ..()
	if(!HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		user.changeNext_move(CLICK_CD_MELEE * 0.5) //when closed, it attacks very rapidly

/obj/item/melee/trick/cleaving_saw/attack(mob/living/target, mob/living/carbon/human/user)
	if(!HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE) || swiping || !target.density || get_turf(target) == get_turf(user))
		..()
	else
		var/turf/user_turf = get_turf(user)
		var/dir_to_target = get_dir(user_turf, get_turf(target))
		swiping = TRUE
		var/static/list/cleaving_saw_cleave_angles = list(0, -45, 45) //so that the animation animates towards the target clicked and not towards a side target
		for(var/i in cleaving_saw_cleave_angles)
			var/turf/T = get_step(user_turf, turn(dir_to_target, i))
			for(var/mob/living/L in T)
				if(user.Adjacent(L) && L.density)
					melee_attack_chain(user, L)
		swiping = FALSE

/obj/item/melee/trick/cleaving_saw/old
	name = "old cleaving saw"
	desc = "This saw, old and rusted, is still an effective tool at bleeding beasts and monsters."
	force = 10
	active_force = 15 //force when active
	throwforce = 15
	active_throwforce = 15
	bleed_stacks_per_hit = 1.5

/obj/item/melee/trick/hunters_axe
	name = "hunter\'s axe"
	desc = "A one-handed axe weapon that is stronger than a hatchet can be transformed into a two-handed axe weapon that may have damage on-par with a bone axe. It's main advantage is portability. A must-have for any hunter."
	icon_state = "axe"
	base_icon_state = "axe"

	force = 20 // Combat knife
	var/active_force = 35 //5 higher then a bone axe

	attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")
	hitsound = list('sound/weapons/melee/heavyaxe_hit1.ogg', 'sound/weapons/melee/heavyaxe_hit2.ogg')
	pickup_sound = 'sound/weapons/melee/heavy_pickup.ogg'
	sharpness = IS_SHARP

/obj/item/melee/trick/hunters_axe/Initialize()
	. = ..()
	AddComponent( \
		/datum/component/two_handed, \
		force_wielded = active_force, \
		force_unwielded = force, \
		icon_wielded = "[base_icon_state]_on" \
	)

/obj/item/melee/trick/hunters_axe/update_icon_state()
	icon_state = "[base_icon_state]"
	return ..()

/obj/item/melee/trick/hunters_axe/melee_attack_chain(mob/user, atom/target, params)
	. = ..()
	force -= 1 //Knowing two_handed will reset this value, this acts as a "dulling" that encourages players to swap between the two modes
