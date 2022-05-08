#define CHARGE_INDICATOR_ANGLE_CHANGE_THRESHOLD 0.1

/obj/item
	var/combat_capable = FALSE //Whether it can swing as a weapon.
	var/attack_range = 3
	var/combat_skill = null //Combat skill used (/datum/skill/melee)
	var/minimum_combat_skill = 0 //If combat skill is lower than this, big damage debuff. for guns, big inaccuracy
	var/parry_class = 1

/obj/item/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
	if (!combat_capable)
		return
	if (!istype(src, /obj/item/melee) && user.combat_mode)
		melee_attack(target, user, flag, params)

/obj/item/proc/melee_attack(atom/target, mob/living/user, proximity_flag, clickparams)
	if (user.next_move > world.time)
		return
	var/turf/proj_turf = user.loc
	if (!isturf(proj_turf))
		return
	if (proximity_flag && !isturf(target))
		return
	user.changeNext_move(CLICK_CD_MELEE)
	var/obj/projectile/melee/M = new /obj/projectile/melee(proj_turf)
	var/modifiers = params2list(clickparams)
	M.preparePixelProjectile(target, user, modifiers)
	M.firer = user
	M.name = name
	M.damage = apply_damage_modifier()
	M.damage_type = damtype
	M.flag = damtype
	M.hitsound = hitsound
	M.def_zone = ran_zone(user.zone_selected)
	M.range = attack_range
	M.parry_class = parry_class
	if (ishuman(user) && combat_skill)
		M.combat_skill = combat_skill
		var/combatant_skill = user.mind.get_skill_level(combat_skill)
		var/effective_skill = user.mind.get_effective_skill(combat_skill)
		if (combatant_skill < minimum_combat_skill)
			M.damage *= 0.3
		else
			M.damage *= 1 + (effective_skill-10)/50
		M.attack_skill = effective_skill
	playsound(user, 'sound/weapons/punchmiss.ogg', 40, 1)
	M.fire()
	user.Immobilize(2)
	after_melee_attack()
	return

/obj/item/proc/after_melee_attack()
	return

/obj/item/proc/apply_damage_modifier()
	return force

/obj/item/melee
	combat_capable = TRUE
	canMouseDown = TRUE
	slot_flags = ITEM_SLOT_BELT
	var/charging_slowdown = 0.5
	var/charging = FALSE
	var/charge_time_left = 2 SECONDS
	var/charge_time = 2 SECONDS
	var/lastangle = 0
	var/indicator_lastangle = 0
	var/last_indicator = 0
	var/last_process = 0
	var/list/obj/effect/projectile/tracer/current_indicators
	var/mob/current_user = null
	parry_class = 1

/obj/item/melee/apply_damage_modifier()
	if (charging)
		return (force/2) + ((charge_time-charge_time_left)/charge_time) * force
	else return force/2

/obj/item/melee/after_melee_attack()
	charging = FALSE

/obj/item/melee/Initialize()
	. = ..()
	current_indicators = list()

/obj/item/melee/pickup(mob/user)
	..()
	START_PROCESSING(SSfastprocess, src)

/obj/item/melee/dropped(mob/user)
	..()
	charging = FALSE
	STOP_PROCESSING(SSfastprocess, src)

/obj/item/melee/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	QDEL_LIST(current_indicators)
	..()

/obj/item/melee/process()
	if (!ishuman(loc))
		STOP_PROCESSING(SSfastprocess, src)
		return
	charge_time_left = max(0, charge_time_left - (world.time - last_process))
	last_process = world.time
	charge_indicator(TRUE)
	mouse_track()

/obj/item/melee/onMouseDown(object, location, params, mob/living/carbon/human/mob)
	if(!ishuman(mob))
		return ..()
	if(istype(object, /atom/movable/screen))// && !istype(object, /obj/screen/click_catcher))
		return
	if((object in mob.contents) || (object == mob))
		return
	if(mob:combat_mode)
		set_user(mob)
		mouse_track()
		start_charging()
	return ..()

/obj/item/melee/onMouseUp(object, location, params, mob/living/carbon/human/M)
	if(!ishuman(M))
		return ..()
	if(istype(object, /atom/movable/screen))// && !istype(object, /obj/screen/click_catcher))
		return
	if(!M.throw_mode && M.combat_mode)
		melee_attack(object, M, M.CanReach(object,src), M.client.mouseParams)
		set_user(null)
	return ..()

obj/item/melee/onMouseDrag(src_object, over_object, src_location, over_location, params, mob)
	if(charging)
		mouse_track()
		charge_indicator()
	return ..()

/obj/item/melee/proc/mouse_track()
	if (istype(current_user) && current_user.client && current_user.client.mouseParams)
		var/angle = mouse_angle_from_client(current_user.client)
		current_user.setDir(angle2dir_cardinal(angle))
		lastangle = angle

obj/item/melee/proc/charge_indicator(force_update = FALSE)
	var/diff = abs(indicator_lastangle - lastangle)
	if(!check_user())
		return
	if(((diff < CHARGE_INDICATOR_ANGLE_CHANGE_THRESHOLD) || ((last_indicator + 1) > world.time)) && !force_update)
		return
	indicator_lastangle = lastangle
	var/obj/projectile/beam/beam_rifle/hitscan/aiming_beam/P = new
	P.melee_weapon = src
	P.range = attack_range
	if(charge_time)
		var/percent = ((100/charge_time)*charge_time_left)
		P.color = rgb(255 * percent,255 * ((100 - percent) / 100),0)
	else
		P.color = rgb(0, 255, 0)
	var/turf/curloc = get_turf(src)
	var/turf/targloc = get_turf(current_user.client.mouseObject)
	if(!istype(targloc))
		if(!istype(curloc))
			return
		targloc = get_turf_in_angle(lastangle, curloc, 10)
	var/mouse_modifiers = params2list(current_user.client.mouseParams)
	P.preparePixelProjectile(targloc, current_user, mouse_modifiers, 0)
	P.fire(lastangle)
	last_indicator = world.time

/obj/item/melee/proc/check_user(automatic_cleanup = TRUE)
	if(!istype(current_user) || !isturf(current_user.loc) || !(src in current_user.held_items) || current_user.incapacitated())	//Doesn't work if you're not holding it!
		if(automatic_cleanup)
			set_user(null)
		return FALSE
	return TRUE

/obj/item/melee/proc/on_mob_move()
	check_user()
	if(charging)
		charge_indicator(TRUE)

/obj/item/melee/proc/start_charging()
	charge_time_left = charge_time
	charging = TRUE
	slowdown = charging_slowdown
	current_user?.update_equipment_speed_mods()

/obj/item/melee/proc/stop_charging()
	set waitfor = FALSE
	charge_time_left = charge_time
	charging = FALSE
	QDEL_LIST(current_indicators)
	slowdown = initial(slowdown)
	current_user?.update_equipment_speed_mods()

/obj/item/melee/proc/set_user(mob/user)
	if(user == current_user)
		return
	stop_charging(current_user)
	if(current_user)
		UnregisterSignal(current_user, COMSIG_MOVABLE_MOVED)
		current_user = null
	if(istype(user))
		current_user = user
		RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/on_mob_move)

/obj/item/melee/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if (!owner.combat_mode)
		return FALSE
	if (istype(hitby,/obj/projectile))
		var/obj/projectile/projectile = hitby
		if (!projectile.parry_class)
			return FALSE
		var/dodge_skill = owner.mind.get_effective_skill(/datum/skill/dodge)
		final_block_chance = 15 * dodge_skill / max(8,projectile.attack_skill)
		if (prob(final_block_chance))
			owner.visible_message(span_danger("[owner] dodges [attack_text]!"))
			playsound(src, pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 75, TRUE)
			return TRUE
		if (parry_class >= projectile.parry_class)
			var/combatant_skill = owner.mind.get_effective_skill(combat_skill)
			final_block_chance = 15 * (parry_class / projectile.parry_class) * (combatant_skill / max(8,projectile.attack_skill))
			if (prob(final_block_chance))
				owner.visible_message(span_danger("[owner] parries [attack_text] with [src]!"))
				playsound(src, pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 75, TRUE)
				return TRUE
	return FALSE

//pseudo-ranged melee attack
/obj/projectile/melee
	name = "swing"
	icon_state = "swing"
	damage = 0
	damage_type = BEAT
	flag = "beat"
	range = 3
	speed = 1.3

/obj/projectile/melee/Initialize()
	. = ..()
	def_zone = ran_zone(BODY_ZONE_CHEST,45)

/obj/projectile/melee/on_hit(atom/target, blocked = FALSE)
	if (combat_skill && ishuman(firer) && firer:mind && isliving(target) && target:stat != DEAD)
		if (blocked < 100)
			firer:mind.adjust_experience(combat_skill, 5)
	. = ..()
