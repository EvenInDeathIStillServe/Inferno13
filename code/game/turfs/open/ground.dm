/turf/open/indestructible/ground
	icon = 'icons/turf/inferno/ground.dmi'
	name = "\proper ground"
	icon_state = "wasteland1"
	planetary_atmos = TRUE

/turf/open/indestructible/ground/singularity_act()
	return

/turf/open/indestructible/ground/can_have_cabling()
	return TRUE

/turf/open/indestructible/ground/outside
	sunlight_state = SUNLIGHT_SOURCE

/turf/open/indestructible/ground/outside/dirt
	name = "dirt"
	icon_state = "dirtfull"
	slowdown = 0.1
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND

/turf/open/indestructible/ground/outside/grass
	name = "grass"
	desc = "Some dead grass."
	icon_state = "savannahcenter"
	slowdown = 0.1
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND

/turf/open/indestructible/ground/outside/dirt/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/plating/inferno/outside
	name = "What the fuck mappers? why is this here"
	desc = "If found, scream at the github repo about this"
	icon_state = "wasteland1"
	icon = 'icons/turf/inferno/desert.dmi'
	sunlight_state = SUNLIGHT_SOURCE

/turf/open/indestructible/ground/outside/road
	name = "\proper road"
	icon_state = "innermiddle"
	icon = 'icons/turf/inferno/asphalt.dmi'

/turf/open/indestructible/ground/outside/sidewalk
	name = "\proper sidewalk"
	icon_state = "outermiddle"
	icon = 'icons/turf/inferno/sidewalk.dmi'

/turf/open/indestructible/ground/outside/ruins
	name = "ruins"
	desc = "It's just a pile of concrete rubble."
	icon_state = "rubblefull"
	icon = 'icons/turf/inferno/ground.dmi'

/turf/open/indestructible/ground/mountain
	name = "cave"
	icon_state = "rockfloor1"
	icon = 'icons/turf/inferno/mining.dmi'

/turf/open/indestructible/ground/mountain/Initialize()
	. = ..()
	for(var/direction in GLOB.cardinals)
		var/turf/turf_to_check = get_step(src, direction)
		if(istype(turf_to_check, /turf/open/water))
			var/obj/effect/overlay/rockfloor_side/DS = new /obj/effect/overlay/rockfloor_side(src)
			switch(direction)
				if(NORTH)
					DS.pixel_y = 32
				if(SOUTH)
					DS.pixel_y = -32
				if(EAST)
					DS.pixel_x = 32
				if(WEST)
					DS.pixel_x = -32
			DS.dir = turn(direction, 180)

/obj/effect/overlay/rockfloor_side
	name = "cave"
	icon = 'icons/turf/inferno/smoothing.dmi'
	icon_state = "rockfloor_side"
	density = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	plane = FLOOR_PLANE
	layer = ABOVE_OPEN_TURF_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE