/* In this file:
 *
 * Plasma floor
 * Gold floor
 * Silver floor
 * Bananium floor
 * Diamond floor
 * Uranium floor
 * Shuttle floor (Titanium)
 */

/turf/open/floor/mineral
	name = "mineral floor"
	icon_state = ""
	material_flags = MATERIAL_EFFECTS
	var/list/icons
	tiled_dirt = FALSE


/turf/open/floor/mineral/Initialize(mapload)
	. = ..()
	icons = typelist("icons", icons)

/turf/open/floor/mineral/broken_states()
	return list("[initial(icon_state)]_dam")

/turf/open/floor/mineral/update_icon_state()
	if(!broken && !burnt && !(icon_state in icons))
		icon_state = initial(icon_state)
	return ..()

//PLASMA

/turf/open/floor/mineral/plasma
	name = "plasma floor"
	icon_state = "plasma"
	floor_tile = /obj/item/stack/tile/mineral/plasma
	icons = list("plasma","plasma_dam")
	custom_materials = list(/datum/material/plasma = SMALL_MATERIAL_AMOUNT*5)

//Plasma floor that can't be removed, for disco inferno

/turf/open/floor/mineral/plasma/disco/crowbar_act(mob/living/user, obj/item/I)
	return


//GOLD

/turf/open/floor/mineral/gold
	name = "gold floor"
	icon_state = "gold"
	floor_tile = /obj/item/stack/tile/mineral/gold
	icons = list("gold","gold_dam")
	custom_materials = list(/datum/material/gold = SMALL_MATERIAL_AMOUNT*5)

//SILVER

/turf/open/floor/mineral/silver
	name = "silver floor"
	icon_state = "silver"
	floor_tile = /obj/item/stack/tile/mineral/silver
	icons = list("silver","silver_dam")
	custom_materials = list(/datum/material/silver = SMALL_MATERIAL_AMOUNT*5)

//TITANIUM (shuttle)

/turf/open/floor/mineral/titanium
	name = "shuttle floor"
	icon_state = "titanium"
	floor_tile = /obj/item/stack/tile/mineral/titanium
	custom_materials = list(/datum/material/titanium = SMALL_MATERIAL_AMOUNT*5)

/turf/open/floor/mineral/titanium/broken_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

/turf/open/floor/mineral/titanium/rust_heretic_act()
	return // titanium does not rust

/turf/open/floor/mineral/titanium/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/mineral/titanium/yellow
	icon_state = "titanium_yellow"
	floor_tile = /obj/item/stack/tile/mineral/titanium/yellow

/turf/open/floor/mineral/titanium/yellow/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/mineral/titanium/blue
	icon_state = "titanium_blue"
	floor_tile = /obj/item/stack/tile/mineral/titanium/blue

/turf/open/floor/mineral/titanium/blue/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/mineral/titanium/white
	icon_state = "titanium_white"
	floor_tile = /obj/item/stack/tile/mineral/titanium/white

/turf/open/floor/mineral/titanium/white/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/mineral/titanium/purple
	icon_state = "titanium_purple"
	floor_tile = /obj/item/stack/tile/mineral/titanium/purple

/turf/open/floor/mineral/titanium/purple/airless
	initial_gas_mix = AIRLESS_ATMOS

// OLD TITANIUM (titanium floor tiles before PR #50454)
/turf/open/floor/mineral/titanium/tiled
	name = "titanium tile"
	icon_state = "titanium_tiled"
	floor_tile = /obj/item/stack/tile/mineral/titanium/tiled

/turf/open/floor/mineral/titanium/tiled/broken_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

/turf/open/floor/mineral/titanium/tiled/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/mineral/titanium/tiled/yellow
	icon_state = "titanium_tiled_yellow"
	floor_tile = /obj/item/stack/tile/mineral/titanium/tiled/yellow

/turf/open/floor/mineral/titanium/tiled/yellow/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/mineral/titanium/tiled/blue
	icon_state = "titanium_tiled_blue"
	floor_tile = /obj/item/stack/tile/mineral/titanium/tiled/blue

/turf/open/floor/mineral/titanium/tiled/blue/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/mineral/titanium/tiled/white
	icon_state = "titanium_tiled_white"
	floor_tile = /obj/item/stack/tile/mineral/titanium/tiled/white

/turf/open/floor/mineral/titanium/tiled/white/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/mineral/titanium/tiled/purple
	icon_state = "titanium_tiled_purple"
	floor_tile = /obj/item/stack/tile/mineral/titanium/tiled/purple

/turf/open/floor/mineral/titanium/tiled/purple/airless
	initial_gas_mix = AIRLESS_ATMOS

//PLASTITANIUM (syndieshuttle)
/turf/open/floor/mineral/plastitanium
	name = "shuttle floor"
	icon_state = "plastitanium"
	floor_tile = /obj/item/stack/tile/mineral/plastitanium
	custom_materials = list(/datum/material/alloy/plastitanium = SMALL_MATERIAL_AMOUNT*5)

/turf/open/floor/mineral/plastitanium/broken_states()
	return list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")

/turf/open/floor/mineral/plastitanium/rust_heretic_act()
	return // plastitanium does not rust

/turf/open/floor/mineral/plastitanium/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/mineral/plastitanium/red
	icon_state = "plastitanium_red"
	floor_tile = /obj/item/stack/tile/mineral/plastitanium/red

/turf/open/floor/mineral/plastitanium/red/airless
	initial_gas_mix = AIRLESS_ATMOS

//Used in SnowCabin.dm
/turf/open/floor/mineral/plastitanium/red/snow_cabin
	temperature = 180

//BANANIUM

/turf/open/floor/mineral/bananium
	name = "bananium floor"
	icon_state = "bananium"
	floor_tile = /obj/item/stack/tile/mineral/bananium
	icons = list("bananium","bananium_dam")
	custom_materials = list(/datum/material/bananium = SMALL_MATERIAL_AMOUNT*5)
	material_flags = NONE //The slippery comp makes it unpractical for good clown decor. The custom mat one should still slip.
	var/sound_cooldown = 0

/turf/open/floor/mineral/bananium/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(.)
		return
	if(isliving(arrived))
		squeak()

/turf/open/floor/mineral/bananium/attackby(obj/item/W, mob/user, params)
	.=..()
	if(!.)
		honk()

/turf/open/floor/mineral/bananium/attack_hand(mob/user, list/modifiers)
	.=..()
	if(!.)
		honk()

/turf/open/floor/mineral/bananium/attack_paw(mob/user, list/modifiers)
	.=..()
	if(!.)
		honk()

/turf/open/floor/mineral/bananium/proc/honk()
	if(sound_cooldown < world.time)
		playsound(src, 'sound/items/bikehorn.ogg', 50, TRUE)
		sound_cooldown = world.time + 20

/turf/open/floor/mineral/bananium/proc/squeak()
	if(sound_cooldown < world.time)
		playsound(src, SFX_CLOWN_STEP, 50, TRUE)
		sound_cooldown = world.time + 10

/turf/open/floor/mineral/bananium/airless
	initial_gas_mix = AIRLESS_ATMOS

//DIAMOND

/turf/open/floor/mineral/diamond
	name = "diamond floor"
	icon_state = "diamond"
	floor_tile = /obj/item/stack/tile/mineral/diamond
	icons = list("diamond","diamond_dam")
	custom_materials = list(/datum/material/diamond = SMALL_MATERIAL_AMOUNT*5)

//URANIUM

/turf/open/floor/mineral/uranium
	article = "a"
	name = "uranium floor"
	icon_state = "uranium"
	floor_tile = /obj/item/stack/tile/mineral/uranium
	icons = list("uranium","uranium_dam")
	custom_materials = list(/datum/material/uranium = SMALL_MATERIAL_AMOUNT*5)
	var/last_event = 0
	var/active = null

/turf/open/floor/mineral/uranium/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(.)
		return
	if(isliving(arrived))
		radiate()

/turf/open/floor/mineral/uranium/attackby(obj/item/W, mob/user, params)
	.=..()
	if(!.)
		radiate()

/turf/open/floor/mineral/uranium/attack_hand(mob/user, list/modifiers)
	.=..()
	if(!.)
		radiate()

/turf/open/floor/mineral/uranium/attack_paw(mob/user, list/modifiers)
	.=..()
	if(!.)
		radiate()

/turf/open/floor/mineral/uranium/proc/radiate()
	if(!active)
		if(world.time > last_event+15)
			active = TRUE
			radiation_pulse(
				src,
				max_range = 1,
				threshold = RAD_VERY_LIGHT_INSULATION,
				chance = (URANIUM_IRRADIATION_CHANCE / 3),
				minimum_exposure_time = URANIUM_RADIATION_MINIMUM_EXPOSURE_TIME,
			)
			for(var/turf/open/floor/mineral/uranium/T in orange(1,src))
				T.radiate()
			last_event = world.time
			active = FALSE
			return

// ALIEN ALLOY
/turf/open/floor/mineral/abductor
	name = "alien floor"
	icon_state = "alienpod1"
	floor_tile = /obj/item/stack/tile/mineral/abductor
	icons = list("alienpod1", "alienpod2", "alienpod3", "alienpod4", "alienpod5", "alienpod6", "alienpod7", "alienpod8", "alienpod9")
	baseturfs = /turf/open/floor/plating/abductor2
	custom_materials = list(/datum/material/alloy/alien = SMALL_MATERIAL_AMOUNT*5)

/turf/open/floor/mineral/abductor/Initialize(mapload)
	. = ..()
	icon_state = "alienpod[rand(1,9)]"

/turf/open/floor/mineral/abductor/break_tile()
	return //unbreakable

/turf/open/floor/mineral/abductor/burn_tile()
	return //unburnable

/turf/open/floor/mineral/reagent
	name = "reagent floor"
	icon_state = "titanium_white"
	floor_tile = /obj/item/stack/tile/mineral/reagent
	icons = list("titanium_white","titanium_dam1")
	var/datum/reagent/reagent_type
	var/obj/effect/particle_effect/fakeholder

/turf/open/floor/mineral/reagent/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature && !fakeholder)
		fakeholder = new(get_turf(src))
		fakeholder.create_reagents(50)
		fakeholder.reagents.add_reagent(reagent_type.type, 50, reagtemp = exposed_temperature)
		fakeholder.reagents.handle_reactions()
		QDEL_IN(fakeholder, 150)

	else if(exposed_temperature && fakeholder && !QDELETED(fakeholder))
		fakeholder.reagents.chem_temp = exposed_temperature
		fakeholder.reagents.handle_reactions()




/turf/open/floor/mineral/reagent/proc/reagent_act(atom/A)
	if(reagent_type)
		reagent_type.expose_turf(src, TOUCH, 3)
		if(prob(90))
			if(isliving(A))
				reagent_type.expose_mob(A, TOUCH, 3)
			else if(isturf(A))
				reagent_type.expose_turf(A, TOUCH, 3)
			else if(isobj(A))
				reagent_type.expose_obj(A, TOUCH, 3)
		else if(reagent_type)
			for(var/atom/AM in view(1, src))
				if(isliving(AM))
					reagent_type.expose_mob(AM, TOUCH, 3)
				else if(isturf(AM))
					reagent_type.expose_turf(AM, TOUCH, 3)
				else if(isobj(AM))
					reagent_type.expose_obj(AM, TOUCH, 3)


/turf/open/floor/mineral/reagent/attack_hand(mob/user)
	reagent_act(user)
	..()

/turf/open/floor/mineral/reagent/attack_paw(mob/user)
	reagent_act(user)
	..()

/turf/open/floor/mineral/reagent/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	.=..()
	if(!.)
		reagent_act(arrived)

/turf/open/floor/mineral/reagent/attackby(obj/item/I, mob/user, params)
	var/hotness = I.get_temperature()
	if(hotness)
		temperature_expose(exposed_temperature = hotness)
		to_chat(user, "<span class='warning'>You heat [src] with [I]!</span>")
		message_admins("[src] of [reagent_type] was heated by [ADMIN_LOOKUPFLW(user)] with [I] in [ADMIN_VERBOSEJMP(src)]")
		log_game("[src] of [reagent_type] was heated by [ADMIN_LOOKUPFLW(user)] with [I] in [AREACOORD(src)]")
	..()

/turf/open/floor/mineral/reagent/ex_act()
	if(!(fakeholder && fakeholder.reagents && !QDELETED(fakeholder)))
		fakeholder = new(get_turf(src))
		fakeholder.create_reagents(30)
		fakeholder.reagents.add_reagent(reagent_type.type, 50)
		fakeholder.reagents.handle_reactions()
		QDEL_IN(fakeholder, 150)
	..()

/turf/open/floor/mineral/reagent/remove_tile(mob/user, silent = FALSE, make_tile = TRUE)
	if(broken || burnt)
		broken = FALSE
		burnt = FALSE
		if(user && !silent)
			to_chat(user, "<span class='notice'>You remove the broken plating.</span>")
	else
		if(user && !silent)
			to_chat(user, "<span class='notice'>You remove the floor tile.</span>")
		if(floor_tile && make_tile)
			var/obj/item/stack/tile/mineral/reagent/F = new floor_tile(src)
			var/paths = subtypesof(/datum/reagent)
			for(var/path in paths)
				var/datum/reagent/RR = new path
				if(RR.type == reagent_type.type)
					F.reagent_type = RR
					F.name ="[reagent_type] floor tiles"
					F.singular_name = "[reagent_type] floor tile"
					F.desc = "floor tiles made of [reagent_type]"
					F.add_atom_colour(reagent_type.color, FIXED_COLOUR_PRIORITY)
					break
				else
					qdel(RR)
	return make_plating()

/turf/open/floor/mineral/reagent/Destroy()
	if(fakeholder)
		QDEL_NULL(fakeholder)
	return ..()
