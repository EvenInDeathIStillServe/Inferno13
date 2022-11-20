/obj/item
	var/combat_capable = FALSE //Whether it can swing as a weapon.
	var/attack_range = 3
	var/combat_skill = null //Combat skill used (/datum/skill/melee)
	var/minimum_combat_skill = 0 //If combat skill is lower than this, big damage debuff. for guns, big inaccuracy
	var/parry_class = 1
	var/last_attack = 0
	var/charge_time = 2 SECONDS

/obj/item/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
	if (!combat_capable)
		return
	if (user.combat_mode)
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
	M.icon = icon
	M.icon_state = icon_state
	M.alpha = 150
	if (last_attack + charge_time <= world.time)
		M.color = COLOR_RED
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
	last_attack = world.time
	user.do_attack_animation(target, no_effect = TRUE)
	user.Immobilize(2)
	after_melee_attack()
	return

/obj/item/proc/after_melee_attack()
	return

/obj/item/proc/apply_damage_modifier()
	return force

/obj/item/melee
	combat_capable = TRUE
	slot_flags = ITEM_SLOT_BELT
	parry_class = 1

/obj/item/melee/apply_damage_modifier()
	return force/2 + (min(force/2, force * ((world.time - last_attack)/charge_time)))

/obj/item/melee/after_melee_attack()

/obj/item/melee/pickup(mob/user)
	..()
	last_attack = world.time

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
