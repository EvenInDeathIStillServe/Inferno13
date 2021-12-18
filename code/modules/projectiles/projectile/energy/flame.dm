/obj/projectile/energy/flame
	name = "flame blast"
	icon_state = "fireball"
	damage = 30
	damage_type = ENFLAME
	speed = 1.3

/obj/projectile/energy/flame/on_hit(atom/target)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(3)
		M.IgniteMob()