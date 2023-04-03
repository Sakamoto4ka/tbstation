/obj/item/melee/nunchaku
	name = "sledgehammer"
	desc = "Traditional Okinawan martial arts weapon"
	force = 2
	icon_state = "sledgehammer0"
	base_icon_state = "sledgehammer"
	icon = 'massmeta/icons/obj/sledgehammer.dmi'
	lefthand_file = 'massmeta/icons/mob/inhands/sledgehammer_lefthand.dmi'
	righthand_file = 'massmeta/icons/mob/inhands/sledgehammer_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BELT
	wound_bonus = -10
	demolition_mod = 0.25
	throw_range = 2

	var/stamina_damage = 11
	var/fast_attack_speed = CLICK_CD_MELEE / 2

	var/attack_sound = 'sound/effects/woodhit.ogg'

/obj/item/melee/nunchaku/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, \
		icon_wielded = "[base_icon_state]1", \
		force_unwielded = 2, \
		force_wielded = 4, \
	)

/obj/item/melee/nunchaku/update_icon_state()
	icon_state = "[base_icon_state]0"
	return ..()

/obj/item/melee/nunchaku/proc/check_parried(mob/living/carbon/human/human_target, mob/living/user)
	if(!ishuman(human_target))
		return
	if (human_target.check_shields(src, 0, "[user]'s [name]", MELEE_ATTACK))
		playsound(human_target, 'sound/weapons/genhit.ogg', 50, TRUE)
		return TRUE
	if(check_martial_counter(human_target, user))
		return TRUE

/obj/item/melee/nunchaku/attack(mob/living/target, mob/living/user, params)

	if(QDELETED(target))
		return
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		return
	if(check_parried(target, user))
		return BATON_ATTACK_DONE

	if((HAS_TRAIT(user, TRAIT_CLUMSY)) && prob(30))
		user.visible_message(span_danger("[user] accidentally hits [user.p_them()]self with [src]!"), span_userdanger("You accidentally hit yourself with [src]!"))
		user.Knockdown(2 SECONDS)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.apply_damage(3*force, BRUTE, BODY_ZONE_HEAD)
		else
			user.take_bodypart_damage(3*force)
		..()
		return

	user.do_attack_animation(target)

	var/list/modifiers = params2list(params)

	check_parried(target, user)

	if(!HAS_TRAIT(src, TRAIT_WIELDED) || LAZYACCESS(modifiers, RIGHT_CLICK))
		if(prob(5))
			user.Knockdown(1 SECONDS)
			user.visible_message(span_danger("[user] accidentally hits [user.p_them()]self with [src]!"), span_userdanger("You accidentally hit yourself with [src]!"))
			return
		..()
		user.changeNext_move(fast_attack_speed)
		return

	user.changeNext_move(fast_attack_speed)
	target.apply_damage(stamina_damage, STAMINA)

	playsound(get_turf(src), attack_sound, 50, TRUE)

	target.visible_message(span_danger("[user] knocks [target] down with [src]!"), \
		span_userdanger("[user] knocks you down with [src]!"))
