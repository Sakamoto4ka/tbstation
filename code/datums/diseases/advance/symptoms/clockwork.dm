/datum/symptom/robotic_adaptation
	name = "Biometallic Replication"
	desc = "The virus can manipulate metal and silicate compounds, becoming able to infect robotic beings."
	stealth = 0
	resistance = 1
	stage_speed = 4 //while the reference material has low speed, this virus will take a good while to completely convert someone
	transmittable = -1
	level = 8
	severity = 0
	symptom_delay_min = 10
	symptom_delay_max = 30
	var/replaceorgans = FALSE
	var/replacebody = FALSE
	var/robustbits = FALSE
	threshold_descs = list("Stage Speed 4" = "The virus will replace the host's organic organs with mundane, biometallic versions. +1 severity.",
					  "Resistance 4" ="The virus will eventually convert the host's entire body to biometallic materials, and maintain its cellular integrity. +1 severity.",
					  "Stage Speed 12" = "Biometallic mass created by the virus will be superior to typical organic mass. -3 severity.",)

/datum/symptom/robotic_adaptation/OnAdd(datum/disease/advance/A)
	A.infectable_biotypes |= MOB_ROBOTIC

/datum/symptom/robotic_adaptation/proc/severityset(datum/disease/advance/A)
	severity = initial(severity)
	if(A.totalStageSpeed() >= 4) //at base level, robotic organs are purely a liability
		severity += 1
		if(A.totalStageSpeed() >= 12)//but at this threshold, it all becomes worthwhile, though getting augged is a better choice
			severity -= 3//net benefits: 2 damage reduction, filter out low amounts of gas, durable ears, flash protection, a liver half as good as an upgraded cyberliver, and flight if you are a winged species
	if(A.totalResistance() >= 4)//at base level, robotic bodyparts have very few bonuses, mostly being a liability in the case of EMPS
		severity += 1 //at this stage, even one EMP will hurt, a lot.


/datum/symptom/robotic_adaptation/Start(datum/disease/advance/A)
	. = ..()
	severityset(A)
	if(A.totalStageSpeed() >= 4)
		replaceorgans = TRUE
	if(A.totalResistance() >= 4)
		replacebody = TRUE
	if(A.totalStageSpeed() >= 12)
		robustbits = TRUE //note that having this symptom means most healing symptoms won't work on you


/datum/symptom/robotic_adaptation/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/human/H = A.affected_mob
	switch(A.stage)
		if(3, 4)
			if(replaceorgans)
				to_chat(H, "<span class='warning'><b>[pick("You feel a grinding pain in your abdomen.", "You exhale a jet of steam.")]</span>")
		if(5)
			if(replaceorgans || replacebody)
				Replace(H)
	return

/datum/symptom/robotic_adaptation/proc/Replace(mob/living/carbon/H)
	if(replaceorgans)
		for(var/obj/item/organ/internal/O in H.organs)
			if(O.status == ORGAN_ROBOTIC || (O.organ_flags & ORGAN_SYNTHETIC)) //they are either part robotic or we already converted them!
				continue
			switch(O.slot) //i hate doing it this way, but the cleaner way runtimes and does not work
				if(ORGAN_SLOT_BRAIN)
					O.name = "enigmatic gearbox"
					O.desc ="An engineer would call this inconcievable wonder of gears and metal a 'black box'"
					O.icon_state = "brain-clock"
					O.status = ORGAN_ROBOTIC
					O.organ_flags = ORGAN_SYNTHETIC
					break
				if(ORGAN_SLOT_STOMACH)
					var/obj/item/organ/internal/stomach/clockwork/organ = new()
					organ.Insert(H, TRUE, FALSE)
					if(prob(40))
						to_chat(H, "<span class='userdanger'>You feel a stabbing pain in your abdomen!</span>")
						H.emote("scream")
					break
				if(ORGAN_SLOT_EARS)
					var/obj/item/organ/internal/ears/robot/clockwork/organ = new()
					if(robustbits)
						organ.damage_multiplier = 0.5
					organ.Insert(H, TRUE, FALSE)
					to_chat(H, "<span class='warning'>Your ears pop.</span>")
					break
				if(ORGAN_SLOT_EYES)
					var/obj/item/organ/internal/eyes/robotic/clockwork/organ = new()
					if(robustbits)
						organ.flash_protect = 1
					organ.Insert(H, TRUE, FALSE)
					if(prob(40))
						to_chat(H, "<span class='userdanger'>You feel a stabbing pain in your eyeballs!</span>")
						H.emote("scream")
					break
				if(ORGAN_SLOT_LUNGS)
					var/obj/item/organ/internal/lungs/clockwork/organ = new()
					if(robustbits)
						organ.safe_plasma_max = 15
						organ.safe_co2_max = 15
						organ.n2o_para_min = 15
						organ.n2o_sleep_min = 15
						organ.BZ_trip_balls_min = 15
						organ.gas_stimulation_min = 15
					organ.Insert(H, TRUE, FALSE)
					if(prob(40))
						to_chat(H, "<span class='userdanger'>You feel a stabbing pain in your chest!</span>")
						H.emote("scream")
					break
				if(ORGAN_SLOT_HEART)
					var/obj/item/organ/internal/heart/clockwork/organ = new()
					organ.Insert(H, TRUE, FALSE)
					to_chat(H, "<span class='userdanger'>You feel a stabbing pain in your chest!</span>")
					H.emote("scream")
					break
				if(ORGAN_SLOT_LIVER)
					var/obj/item/organ/internal/liver/clockwork/organ = new()
					if(robustbits)
						organ.toxTolerance = 7
					organ.Insert(H, TRUE, FALSE)
					if(prob(40))
						to_chat(H, "<span class='userdanger'>You feel a stabbing pain in your abdomen!</span>")
						H.emote("scream")
					break
				if(ORGAN_SLOT_TONGUE)
					if(robustbits)
						var/obj/item/organ/internal/tongue/robot/clockwork/better/organ = new()
						organ.Insert(H, TRUE, FALSE)
					else
						var/obj/item/organ/internal/tongue/robot/clockwork/organ = new()
						organ.Insert(H, TRUE, FALSE)
					break
	if(replacebody)
		for(var/obj/item/bodypart/O in H.bodyparts)
			if(!IS_ORGANIC_LIMB(O))
				if(robustbits && O.brute_reduction < 3 || O.burn_reduction < 2)
					O.burn_reduction = max(2, O.burn_reduction)
					O.brute_reduction = max(3, O.brute_reduction)
				continue
			switch(O.body_zone)
				if(BODY_ZONE_HEAD)
					var/obj/item/bodypart/head/robot/clockwork/B = new /obj/item/bodypart/head/robot/clockwork (H)
					if(robustbits)
						B.brute_reduction = 3 //this is just below the amount that lets augs ignore space damage.
						B.burn_reduction = 2
					H.visible_message("<span class='notice'>[H]'s head shifts, and becomes metal before your very eyes", "<span_class='userdanger'>Your head feels numb, and cold.</span>")
					H.del_and_replace_bodypart(B, special = TRUE)
					return TRUE
				if(BODY_ZONE_CHEST)
					var/obj/item/bodypart/chest/robot/clockwork/B = new /obj/item/bodypart/chest/robot/clockwork (H)
					if(robustbits)
						B.brute_reduction = 3
						B.burn_reduction = 2
					H.visible_message("<span class='notice'>[H]'s [O] shifts, and becomes metal before your very eyes", "<span_class='userdanger'>Your [O] feels numb, and cold.</span>")
					H.del_and_replace_bodypart(B, special = TRUE)
					return TRUE
				if(BODY_ZONE_L_ARM)
					var/obj/item/bodypart/l_arm/robot/clockwork/B = new /obj/item/bodypart/l_arm/robot/clockwork (H)
					if(robustbits)
						B.brute_reduction = 3
						B.burn_reduction = 2
					H.visible_message("<span class='notice'>[H]'s [O] shifts, and becomes metal before your very eyes", "<span_class='userdanger'>Your [O] feels numb, and cold.</span>")
					H.del_and_replace_bodypart(B, special = TRUE)
					return TRUE
				if(BODY_ZONE_R_ARM)
					var/obj/item/bodypart/r_arm/robot/clockwork/B = new /obj/item/bodypart/r_arm/robot/clockwork (H)
					if(robustbits)
						B.brute_reduction = 3
						B.burn_reduction = 2
					H.visible_message("<span class='notice'>[H]'s [O] shifts, and becomes metal before your very eyes", "<span_class='userdanger'>Your [O] feels numb, and cold.</span>")
					H.del_and_replace_bodypart(B, special = TRUE)
					return TRUE
				if(BODY_ZONE_L_LEG)
					var/obj/item/bodypart/l_leg/robot/clockwork/B = new /obj/item/bodypart/l_leg/robot/clockwork (H)
					if(robustbits)
						B.brute_reduction = 3
						B.burn_reduction = 2
					H.visible_message("<span class='notice'>[H]'s [O] shifts, and becomes metal before your very eyes", "<span_class='userdanger'>Your [O] feels numb, and cold.</span>")
					H.del_and_replace_bodypart(B, special = TRUE)
					return TRUE
				if(BODY_ZONE_R_LEG)
					var/obj/item/bodypart/r_leg/robot/clockwork/B = new /obj/item/bodypart/r_leg/robot/clockwork (H)
					if(robustbits)
						B.brute_reduction = 3
						B.burn_reduction = 2
					H.visible_message("<span class='notice'>[H]'s [O] shifts, and becomes metal before your very eyes", "<span_class='userdanger'>Your [O] feels numb, and cold.</span>")
					H.del_and_replace_bodypart(B, special = TRUE)
					return TRUE
	return FALSE

/datum/symptom/robotic_adaptation/End(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/human/H = A.affected_mob
	if(A.stage >= 5 && (replaceorgans || replacebody)) //sorry. no disease quartets allowed
		to_chat(H, "<span class='userdanger'>You feel lighter and springier as your innards lose their clockwork facade.</span>")
		H.dna.species.regenerate_organs(H, replace_current = TRUE)
		for(var/obj/item/bodypart/O in H.bodyparts)
			if(!IS_ORGANIC_LIMB(O))
				O.burn_reduction = initial(O.burn_reduction)
				O.brute_reduction = initial(O.brute_reduction)

/datum/symptom/robotic_adaptation/OnRemove(datum/disease/advance/A)
	A.infectable_biotypes -= MOB_ROBOTIC

//below this point lies all clockwork bits that make this symptom tick. no pun intended.
/obj/item/organ/internal/ears/robot/clockwork
	name = "biometallic recorder"
	desc = "An odd sort of microphone that looks grown, rather than built."
	icon_state = "ears-clock"

/obj/item/organ/internal/eyes/robotic/clockwork
	name = "biometallic receptors"
	desc = "A fragile set of small, mechanical cameras."
	icon_state = "clockwork_eyeballs"

/obj/item/organ/internal/heart/clockwork //this heart doesnt have the fancy bits normal cyberhearts do. However, it also doesnt fucking kill you when EMPd
	name = "biomechanical pump"
	desc = "A complex, multi-valved hydraulic pump, which fits perfectly where a heart normally would."
	icon_state = "heart-clock"
	organ_flags = ORGAN_SYNTHETIC
	status = ORGAN_ROBOTIC

/obj/item/organ/internal/stomach/clockwork
	name = "nutriment refinery"
	desc = "A biomechanical furnace, which turns calories into mechanical energy."
	icon_state = "stomach-clock"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/internal/stomach/clockwork/emp_act(severity)
	owner.adjust_nutrition(-200/severity)

/obj/item/organ/internal/tongue/robot/clockwork
	name = "dynamic micro-phonograph"
	desc = "An old-timey looking device connected to an odd, shifting cylinder."
	icon_state = "tongueclock"

/obj/item/organ/internal/tongue/robot/clockwork/better
	name = "amplified dynamic micro-phonograph"

/obj/item/organ/internal/tongue/robot/clockwork/better/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT
	speech_args[SPEECH_SPANS] |= SPAN_REALLYBIG  //yes, this is a really really good idea, trust me

/obj/item/organ/internal/brain/clockwork
	name = "enigmatic gearbox"
	desc ="An engineer would call this inconcievable wonder of gears and metal a 'black box'"
	icon_state = "brain-clock"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC
	var/robust //Set to true if the robustbits causes brain replacement. Because holy fuck is the CLANG CLANG CLANG CLANG annoying

/obj/item/organ/internal/brain/clockwork/emp_act(severity)
	switch(severity)
		if(1)
			owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 75)
		if(2)
			owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 25)

/obj/item/organ/internal/brain/clockwork/on_life()
	. = ..()
	if(prob(5) && !robust)
		SEND_SOUND(owner, pick('sound/effects/clock_tick.ogg', 'sound/effects/smoke.ogg', 'sound/ambience/ambiruin3.ogg'))

/obj/item/organ/internal/liver/clockwork
	name = "biometallic alembic"
	desc = "A series of small pumps and boilers, designed to facilitate proper metabolism."
	icon_state = "liver-clock"
	organ_flags = ORGAN_SYNTHETIC
	status = ORGAN_ROBOTIC
	alcohol_tolerance = 0
	liver_resistance = 0
	toxTolerance = 1 //while the organ isn't damaged by doing its job, it doesnt do it very well

/obj/item/organ/internal/lungs/clockwork
	name = "clockwork diaphragm"
	desc = "A utilitarian bellows which serves to pump oxygen into an automaton's body."
	icon_state = "lungs-clock"
	organ_flags = ORGAN_SYNTHETIC
	status = ORGAN_ROBOTIC

/obj/item/bodypart/l_arm/robot/clockwork
	name = "clockwork left arm"
	desc = "An odd metal arm with fingers driven by blood-based hydraulics."
	icon = 'icons/mob/augmentation/augments_clockwork.dmi'
	icon_static = 'icons/mob/augmentation/augments_clockwork.dmi'
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/r_arm/robot/clockwork
	name = "clockwork right arm"
	desc = "An odd metal arm with fingers driven by blood-based hydraulics."
	icon = 'icons/mob/augmentation/augments_clockwork.dmi'
	icon_static = 'icons/mob/augmentation/augments_clockwork.dmi'
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/l_leg/robot/clockwork
	name = "clockwork left leg"
	desc = "An odd metal leg full of intricate mechanisms."
	icon = 'icons/mob/augmentation/augments_clockwork.dmi'
	icon_static = 'icons/mob/augmentation/augments_clockwork.dmi'
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/r_leg/robot/clockwork
	name = "clockwork right leg"
	desc = "An odd metal leg full of intricate mechanisms."
	icon = 'icons/mob/augmentation/augments_clockwork.dmi'
	icon_static = 'icons/mob/augmentation/augments_clockwork.dmi'
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/head/robot/clockwork
	name = "clockwork head"
	desc = "An odd metal head that still feels warm to the touch."
	icon = 'icons/mob/augmentation/augments_clockwork.dmi'
	icon_static = 'icons/mob/augmentation/augments_clockwork.dmi'
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/chest/robot/clockwork
	name = "clockwork torso"
	desc = "An odd metal body full of gears and pipes. It still seems alive."
	icon = 'icons/mob/augmentation/augments_clockwork.dmi'
	icon_static = 'icons/mob/augmentation/augments_clockwork.dmi'
	brute_reduction = 0
	burn_reduction = 0
