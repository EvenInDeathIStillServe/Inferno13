/obj/structure/nest
	name = "monster nest"
	desc = "A horrible nest full of monsters."
	icon = 'icons/obj/mob_spawners.dmi'
	icon_state = "hole"
	var/list/spawned_mobs = list()
	var/max_mobs = 1
	var/mob_types = list(/mob/living/simple_animal/hostile/carp)
	var/spawn_delay = 0
	//make spawn_time's multiples of 10. The SS runs on 10 seconds.
	var/spawn_time = 30 SECONDS
	var/coverable = FALSE
	var/covered = FALSE
	var/obj/covertype
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/spawn_text = "emerges from"
	anchored = TRUE
	layer = BELOW_OBJ_LAYER

/obj/structure/nest/Initialize()
	. = ..()
	GLOB.mob_nests += src

/obj/structure/nest/Destroy()
	GLOB.mob_nests -= src
	. = ..()

/obj/structure/nest/proc/spawn_mob()
	if (covered)
		return FALSE
	if (world.time < spawn_delay)
		return 0
	if (viewed_by_player())
//		addtimer(CALLBACK(src, .proc/spawn_mob), 1 MINUTES)
		return FALSE
	spawn_delay = world.time + spawn_time
	if (spawned_mobs.len >= max_mobs)
		return FALSE
	var/chosen_mob_type = pick_weight(mob_types)
	var/mob/living/simple_animal/L = new chosen_mob_type(src.loc)
	L.flags_1 |= (flags_1 & ADMIN_SPAWNED_1)	//If we were admin spawned, lets have our children count as that as well.
	spawned_mobs += L
	L.nest = src
	visible_message("<span class='danger'>[L] [spawn_text] [src].</span>")

/obj/structure/nest/attackby(obj/item/I, mob/living/user, params)
	if(user.combat_mode)
		to_chat(user, "<span class='warning'>You feel it is impossible to hit a hole!</span>")
		return
	..()

/obj/structure/nest/clone
	name = "cloning tube"
	desc = "A chamber continuously spitting out malformed clones."
	icon = 'icons/obj/machines/cloning.dmi'
	icon_state = "pod_1"
	mob_types = list(/mob/living/simple_animal/hostile/humanoid/clone = 1,
					/mob/living/simple_animal/hostile/humanoid/clone/female = 1)
	spawn_time = 2 MINUTES
	spawn_text = "is expelled from"

/obj/structure/nest/hidden
	invisibility = INVISIBILITY_ABSTRACT

/obj/structure/nest/hidden/crackhead
	mob_types = list(/mob/living/simple_animal/hostile/humanoid/crackhead/baseball = 1,
					/mob/living/simple_animal/hostile/humanoid/crackhead/crowbar = 1,
					/mob/living/simple_animal/hostile/humanoid/crackhead/knife = 1)
	spawn_time = 3 MINUTES

/obj/structure/nest/hidden/chud
	mob_types = list(/mob/living/simple_animal/hostile/humanoid/chud = 1)
	spawn_time = 3 MINUTES

/obj/structure/nest/hidden/firefighter
	mob_types = list(/mob/living/simple_animal/hostile/humanoid/firefighter = 1)
	spawn_time = 7 MINUTES

/obj/structure/nest/hidden/hardplace
	mob_types = list(/mob/living/simple_animal/hostile/humanoid/hardplace = 1)
	spawn_time = 7 MINUTES

/obj/structure/nest/hidden/graverobber
	mob_types = list(/mob/living/simple_animal/hostile/humanoid/graverobber/shovel = 1,
					/mob/living/simple_animal/hostile/humanoid/graverobber/baton = 1,
					/mob/living/simple_animal/hostile/humanoid/graverobber/machete = 1)
	spawn_time = 5 MINUTES