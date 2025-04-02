/obj/mecha/proc/get_armour_facing(relative_dir)
	switch(relative_dir)
		if(0) // BACKSTAB!
			return facing_modifiers[MECHA_BACK_ARMOUR]
		if(45, 90, 270, 315)
			return facing_modifiers[MECHA_SIDE_ARMOUR]
		if(225, 180, 135)
			return facing_modifiers[MECHA_FRONT_ARMOUR]
	return 1 //always return non-0

/obj/mecha/proc/attack_dir_for_modules(relative_dir)
	if(relative_dir  > -45 && relative_dir < 45)
		return directional_comps[MECHA_BACK_ARMOUR]
	else if((relative_dir < -45 && relative_dir > -135) || relative_dir > 45 && relative_dir < 135)
		return directional_comps[MECHA_SIDE_ARMOUR]
	else if(relative_dir >= -180 && relative_dir <= 180)
		return directional_comps[MECHA_FRONT_ARMOUR]

/obj/mecha/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	. = ..()
	if(. && obj_integrity > 0)
		spark_system.start()
		switch(damage_flag)
			if("fire")
				check_for_internal_damage(list(MECHA_INT_FIRE,MECHA_INT_TEMP_CONTROL))
			if("melee")
				check_for_internal_damage(list(MECHA_INT_TEMP_CONTROL,MECHA_INT_TANK_BREACH,MECHA_INT_CONTROL_LOST))
			else
				check_for_internal_damage(list(MECHA_INT_FIRE,MECHA_INT_TEMP_CONTROL,MECHA_INT_TANK_BREACH,MECHA_INT_CONTROL_LOST,MECHA_INT_SHORT_CIRCUIT))
		if(. >= 5 || prob(33))
			occupant_message("<span class='userdanger'>Taking damage!</span>")
		log_message("Took [damage_amount] points of damage. Damage type: [damage_type]", LOG_MECHA)

/obj/mecha/run_obj_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	. = ..()
	if(!damage_amount)
		return 0
	var/booster_deflection_modifier = 1
	var/booster_damage_modifier = 1
	if(damage_flag == "bullet" || damage_flag == "laser" || damage_flag == "energy")
		for(var/obj/item/mecha_parts/mecha_equipment/antiproj_armor_booster/B in equipment)
			if(B.projectile_react())
				booster_deflection_modifier = B.deflect_coeff
				booster_damage_modifier = B.damage_coeff
				break
	else if(damage_flag == "melee")
		for(var/obj/item/mecha_parts/mecha_equipment/anticcw_armor_booster/B in equipment)
			if(B.attack_react())
				booster_deflection_modifier *= B.deflect_coeff
				booster_damage_modifier *= B.damage_coeff
				break

	if(attack_dir)
		var/facing_modifier = get_armour_facing(dir2angle(attack_dir) - dir2angle(src))
		booster_damage_modifier /= facing_modifier
		booster_deflection_modifier *= facing_modifier
	if(prob(deflect_chance * booster_deflection_modifier))
		visible_message("<span class='danger'>[src]'s armour deflects the attack!</span>")
		log_message("Armor saved.", LOG_MECHA)
		return 0
	if(.)
		. *= booster_damage_modifier

/obj/mecha/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE) // Ugh. Ideally we shouldn't be setting cooldowns outside of click code.
	user.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
	playsound(loc, 'sound/weapons/tap.ogg', 40, TRUE, -1)
	user.visible_message("<span class='danger'>[user] hits [name]. Nothing happens.</span>", null, null, COMBAT_MESSAGE_RANGE)
	log_message("Attack by hand/paw. Attacker - [user].", LOG_MECHA, color="red")

/obj/mecha/attack_paw(mob/user as mob)
	return attack_hand(user)

/obj/mecha/attack_alien(mob/living/user)
	log_message("Attack by alien. Attacker - [user].", LOG_MECHA, color="red")
	playsound(src.loc, 'sound/weapons/slash.ogg', 100, TRUE)
	attack_generic(user, 15, BRUTE, "melee", 0)

/obj/mecha/attack_animal(mob/living/simple_animal/user)
	log_message("Attack by simple animal. Attacker - [user].", LOG_MECHA, color="red")
	if(!user.melee_damage_upper && !user.obj_damage)
		user.emote("custom", message = "[user.friendly_verb_continuous] [src].")
		return 0
	else
		var/play_soundeffect = 1
		if(user.environment_smash)
			play_soundeffect = 0
			playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
		var/animal_damage = rand(user.melee_damage_lower,user.melee_damage_upper)
		if(user.obj_damage)
			animal_damage = user.obj_damage
		animal_damage = min(animal_damage, 20*user.environment_smash)
		log_combat(user, src, "attacked")
		attack_generic(user, animal_damage, user.melee_damage_type, "melee", play_soundeffect)
		return 1


/obj/mecha/hulk_damage()
	return 15

/obj/mecha/attack_hulk(mob/living/carbon/human/user)
	. = ..()
	if(.)
		log_message("Attack by hulk. Attacker - [user].", LOG_MECHA, color="red")
		log_combat(user, src, "punched", "hulk powers")

/obj/mecha/attack_tk()
	return

/obj/mecha/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum) //wrapper
	log_message("Hit by [AM].", LOG_MECHA, color="red")
	. = ..()

/obj/mecha/bullet_act(obj/projectile/bullet_proj) //wrapper
//allows bullets to hit the pilot of open-canopy mechs
	if (!enclosed \
		&& occupant \
		&& !silicon_pilot \
		&& !bullet_proj.force_hit \
		&& (bullet_proj.def_zone == BODY_ZONE_HEAD || bullet_proj.def_zone == BODY_ZONE_CHEST \
		))
		return occupant.bullet_act(bullet_proj) //If the sides are open, the occupant can be hit

	log_message("Hit by projectile. Type: [bullet_proj.name]([bullet_proj.flag]).", LOG_MECHA, color="red")

	//https://github.com/Foundation-19/Hail-Mary/pull/289
	if(!(bullet_proj.damage_type in list(BRUTE, BURN)))
		return BULLET_ACT_BLOCK
	var/attack_dir = get_dir(src, bullet_proj)
	var/facing_modifier = get_armour_facing(abs(dir2angle(dir) - dir2angle(attack_dir)))
	var/true_armor = clamp(round(armor.bullet*facing_modifier/100 - bullet_proj.armour_penetration ,0.01), 0, 1)
	var/true_damage = round(bullet_proj.damage * (1 - true_armor))
	var/minimum_damage_to_penetrate = round(armor.bullet/3*(1 - bullet_proj.armour_penetration), 0.01)
	if(prob(true_armor/2))
		bullet_proj.setAngle(SIMPLIFY_DEGREES(bullet_proj.Angle + rand(40,150)))
		return BULLET_ACT_FORCE_PIERCE
	bullet_proj.damage = true_damage
	take_damage(true_damage, bullet_proj.damage_type, null, null, attack_dir, bullet_proj.armour_penetration, bullet_proj)
	if(true_damage < minimum_damage_to_penetrate)
		return BULLET_ACT_BLOCK
	var/list/directional_comp = attack_dir_for_modules(abs(dir2angle(attack_dir) - dir2angle(dir)))

	if(prob(directional_comp[1]))
		var/damage_mult = directional_comp[2]
		var/ap_threshold = directional_comp[3]
		var/armor_rating = directional_comp[4]
		damage_mult = min(0.15,(bullet_proj.damage + bullet_proj.armour_penetration) / (bullet_proj.damage + armor_rating))
		directional_comp[4] -= damage_mult * bullet_proj.damage
		take_damage(true_damage * damage_mult, bullet_proj.damage_type, null, null, attack_dir, bullet_proj.armour_penetration, bullet_proj)
		if(bullet_proj.armour_penetration < ap_threshold)
			return BULLET_ACT_BLOCK
		else
			bullet_proj.armour_penetration -= ap_threshold

	var/list/hittable_occupants = list()
	if(occupant)
		hittable_occupants[occupant] = 100

	/* We dont have seats... Yet?
	for(var/obj/item/mecha_parts/mecha_equipment/seat/other_occupant in src)
		if(other_occupant.patient && other_occupant.patient.stat != DEAD)
			hittable_occupants[other_occupant.patient] = 70
	*/

	var/mob/living/true_target = pick_weight(hittable_occupants)
	if(true_target)
		. = true_target.bullet_act(bullet_proj, bullet_proj.def_zone)
	else
		. = ..()

/obj/mecha/run_atom_armor(damage_amount, damage_type, damage_flag = 0, attack_dir, armour_penetration)
	. = ..()
	if(attack_dir)
		var/facing_modifier = get_armour_facing(abs(dir2angle(dir) - dir2angle(attack_dir)))
		if(.)
			. *= facing_modifier

/obj/mecha/ex_act(severity, target)
	log_message("Affected by explosion of severity: [severity].", LOG_MECHA, color="red")
	if(prob(deflect_chance))
		severity++
		log_message("Armor saved, changing severity to [severity]", LOG_MECHA)
	. = ..()

/obj/mecha/contents_explosion(severity, target)
	severity++
	for(var/X in equipment)
		var/obj/item/mecha_parts/mecha_equipment/ME = X
		switch(severity)
			if(EXPLODE_DEVASTATE)
				SSexplosions.highobj += ME
			if(EXPLODE_HEAVY)
				SSexplosions.medobj += ME
			if(EXPLODE_LIGHT)
				SSexplosions.lowobj += ME
	for(var/Y in trackers)
		var/obj/item/mecha_parts/mecha_tracking/MT = Y
		switch(severity)
			if(EXPLODE_DEVASTATE)
				SSexplosions.highobj += MT
			if(EXPLODE_HEAVY)
				SSexplosions.medobj += MT
			if(EXPLODE_LIGHT)
				SSexplosions.lowobj += MT
	if(occupant)
		occupant.ex_act(severity,target)

/obj/mecha/handle_atom_del(atom/A)
	if(A == occupant)
		occupant = null
		icon_state = initial(icon_state)+"-open"
		setDir(dir_in)

/obj/mecha/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_SELF)
		return
	if(get_charge())
		use_power((cell.charge/3)/(severity*2))
		take_damage(30 / severity, BURN, "energy", 1)
	log_message("EMP detected", LOG_MECHA, color="red")

	if(istype(src, /obj/mecha/combat))
		mouse_pointer = 'icons/effects/mouse_pointers/mecha_mouse-disable.dmi'
		occupant?.update_mouse_pointer()
	if(!equipment_disabled && occupant) //prevent spamming this message with back-to-back EMPs
		to_chat(occupant, "<span=danger>Error -- Connection to equipment control unit has been lost.</span>")
	addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/mecha, restore_equipment)), 3 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE)
	equipment_disabled = 1

/obj/mecha/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature>max_temperature)
		log_message("Exposed to dangerous temperature.", LOG_MECHA, color="red")
		take_damage(5, BURN, 0, 1)

/obj/mecha/attackby(obj/item/W as obj, mob/user as mob, params)

	if(istype(W, /obj/item/mmi))
		if(mmi_move_inside(W,user))
			to_chat(user, "<span class='notice'>[src]-[W] interface initialized successfully.</span>")
		else
			to_chat(user, "<span class='warning'>[src]-[W] interface initialization failed.</span>")
		return

	if(istype(W, /obj/item/mecha_ammo))
		ammo_resupply(W, user)
		return

	if(W.GetID())
		if(add_req_access || maint_access)
			if(internals_access_allowed(user))
				var/obj/item/card/id/id_card
				if(istype(W, /obj/item/card/id))
					id_card = W
				else
					var/obj/item/pda/pda = W
					id_card = pda.id
				output_maintenance_dialog(id_card, user)
				return
			to_chat(user, "<span class='warning'>Invalid ID: Access denied.</span>")
			return
		to_chat(user, "<span class='warning'>Maintenance protocols disabled by operator.</span>")
		return

	if(istype(W, /obj/item/stock_parts/cell))
		if(construction_state == MECHA_OPEN_HATCH)
			if(!cell)
				if(!user.transferItemToLoc(W, src, silent = FALSE))
					return
				var/obj/item/stock_parts/cell/C = W
				to_chat(user, "<span class='notice'>You install the power cell.</span>")
				playsound(src, 'sound/items/screwdriver2.ogg', 50, FALSE)
				cell = C
				log_message("Powercell installed", LOG_MECHA)
			else
				to_chat(user, "<span class='warning'>There's already a power cell installed!</span>")
		return

	if(istype(W, /obj/item/stock_parts/scanning_module))
		if(construction_state == MECHA_OPEN_HATCH)
			if(!scanmod)
				if(!user.transferItemToLoc(W, src))
					return
				to_chat(user, "<span class='notice'>You install the scanning module.</span>")
				playsound(src, 'sound/items/screwdriver2.ogg', 50, FALSE)
				scanmod = W
				log_message("[W] installed", LOG_MECHA)
				update_part_values()
			else
				to_chat(user, "<span class='warning'>There's already a scanning module installed!</span>")
		return

	if(istype(W, /obj/item/stock_parts/capacitor))
		if(construction_state == MECHA_OPEN_HATCH)
			if(!capacitor)
				if(!user.transferItemToLoc(W, src))
					return
				to_chat(user, "<span class='notice'>You install the capacitor.</span>")
				playsound(src, 'sound/items/screwdriver2.ogg', 50, FALSE)
				capacitor = W
				log_message("[W] installed", LOG_MECHA)
				update_part_values()
			else
				to_chat(user, "<span class='warning'>There's already a capacitor installed!</span>")
		return

	if(istype(W, /obj/item/stack/cable_coil))
		if(construction_state == MECHA_OPEN_HATCH && (internal_damage & MECHA_INT_SHORT_CIRCUIT))
			var/obj/item/stack/cable_coil/CC = W
			if(CC.use(2))
				clearInternalDamage(MECHA_INT_SHORT_CIRCUIT)
				to_chat(user, "<span class='notice'>You replace the fused wires.</span>")
			else
				to_chat(user, "<span class='warning'>You need two lengths of cable to fix this exosuit!</span>")
		return

	if(istype(W, /obj/item/mecha_parts))
		var/obj/item/mecha_parts/P = W
		P.try_attach_part(user, src)
		return
	log_message("Attacked by [W]. Attacker - [user]", LOG_MECHA)
	return ..()

/obj/mecha/wrench_act(mob/living/user, obj/item/I)
	..()
	. = TRUE
	if(construction_state == MECHA_SECURE_BOLTS)
		construction_state = MECHA_LOOSE_BOLTS
		to_chat(user, "<span class='notice'>You undo the securing bolts.</span>")
		return
	if(construction_state == MECHA_LOOSE_BOLTS)
		construction_state = MECHA_SECURE_BOLTS
		to_chat(user, "<span class='notice'>You tighten the securing bolts.</span>")

/obj/mecha/crowbar_act(mob/living/user, obj/item/I)
	..()
	. = TRUE
	if(construction_state == MECHA_LOOSE_BOLTS)
		construction_state = MECHA_OPEN_HATCH
		to_chat(user, "<span class='notice'>You open the hatch to the power unit.</span>")
		return
	if(construction_state == MECHA_OPEN_HATCH)
		construction_state = MECHA_LOOSE_BOLTS
		to_chat(user, "<span class='notice'>You close the hatch to the power unit.</span>")

/obj/mecha/screwdriver_act(mob/living/user, obj/item/I)
	..()
	. = TRUE
	if(internal_damage & MECHA_INT_TEMP_CONTROL)
		clearInternalDamage(MECHA_INT_TEMP_CONTROL)
		to_chat(user, "<span class='notice'>You repair the damaged temperature controller.</span>")
		return

/obj/mecha/welder_act(mob/living/user, obj/item/W)
	. = ..()
	if(user.a_intent == INTENT_HARM)
		return
	. = TRUE
	if(internal_damage & MECHA_INT_TANK_BREACH)
		if(!W.use_tool(src, user, 0, volume=50, amount=1))
			return
		clearInternalDamage(MECHA_INT_TANK_BREACH)
		to_chat(user, span_notice("You repair the damaged gas tank."))
		return
	while(obj_integrity < max_integrity)
		if(!do_after(user, 20, target= src))
			return
		if(!W.use_tool(src, user, 0, volume=50, amount=1))
			return
		user.visible_message(span_notice("[user] repairs some damage to [name]."), span_notice("You repair some damage to [src]."))
		obj_integrity += min(10 * repair_multiplier, max_integrity-obj_integrity)
		if(obj_integrity == max_integrity)
			to_chat(user, span_notice("It looks to be fully repaired now."))
			return
	to_chat(user, span_warning("The [name] is at full integrity!"))

/obj/mecha/proc/mech_toxin_damage(mob/living/target)
	playsound(src, 'sound/effects/spray2.ogg', 50, TRUE)
	if(target.reagents)
		if(target.reagents.get_reagent_amount(/datum/reagent/cryptobiolin) + force < force*2)
			target.reagents.add_reagent(/datum/reagent/cryptobiolin, force/2)
		if(target.reagents.get_reagent_amount(/datum/reagent/toxin) + force < force*2)
			target.reagents.add_reagent(/datum/reagent/toxin, force/2.5)


/obj/mecha/mech_melee_attack(obj/mecha/M)
	if(!has_charge(melee_energy_drain))
		return 0
	use_power(melee_energy_drain)
	if(M.damtype == BRUTE || M.damtype == BURN)
		log_combat(M.occupant, src, "attacked", M, "(INTENT: [uppertext(M.occupant.a_intent)]) (DAMTYPE: [uppertext(M.damtype)])")
		. = ..()

/obj/mecha/proc/full_repair(charge_cell)
	obj_integrity = max_integrity
	if(cell && charge_cell)
		cell.charge = cell.maxcharge
	if(internal_damage & MECHA_INT_FIRE)
		clearInternalDamage(MECHA_INT_FIRE)
	if(internal_damage & MECHA_INT_TEMP_CONTROL)
		clearInternalDamage(MECHA_INT_TEMP_CONTROL)
	if(internal_damage & MECHA_INT_SHORT_CIRCUIT)
		clearInternalDamage(MECHA_INT_SHORT_CIRCUIT)
	if(internal_damage & MECHA_INT_TANK_BREACH)
		clearInternalDamage(MECHA_INT_TANK_BREACH)
	if(internal_damage & MECHA_INT_CONTROL_LOST)
		clearInternalDamage(MECHA_INT_CONTROL_LOST)

/obj/mecha/narsie_act()
	emp_act(EMP_HEAVY)

/obj/mecha/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	if(!no_effect)
		if(selected)
			used_item = selected
		else if(!visual_effect_icon)
			visual_effect_icon = ATTACK_EFFECT_SMASH
			if(damtype == BURN)
				visual_effect_icon = ATTACK_EFFECT_MECHFIRE
			else if(damtype == TOX)
				visual_effect_icon = ATTACK_EFFECT_MECHTOXIN
	..()

/obj/mecha/obj_destruction()
	if(wreckage)
		var/mob/living/silicon/ai/AI
		if(isAI(occupant))
			AI = occupant
			occupant = null
		var/obj/structure/mecha_wreckage/WR = new wreckage(loc, AI)
		for(var/obj/item/mecha_parts/mecha_equipment/E in equipment)
			if(E.salvageable && prob(30))
				WR.crowbar_salvage += E
				E.detach(WR) //detaches from src into WR
				E.equip_ready = 1
			else
				E.detach(loc)
				qdel(E)
		if(cell)
			WR.crowbar_salvage += cell
			cell.forceMove(WR)
			cell.charge = rand(0, cell.charge)
			cell = null
		if(internal_tank)
			WR.crowbar_salvage += internal_tank
			internal_tank.forceMove(WR)
			cell = null
	. = ..()
