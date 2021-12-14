/turf/open/floor/plating/inferno
	gender = PLURAL
	baseturfs = /turf/open/floor/plating/inferno
	attachment_holes = FALSE
	planetary_atmos = TRUE

/* so we can't break this */
/turf/open/floor/plating/inferno/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/plating/inferno/burn_tile()
	return

/turf/open/floor/plating/inferno/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/plating/inferno/MakeDry()
	return

/turf/open/floor/iron/inferno
	name = "floor"
	icon = 'icons/turf/inferno/if13floors.dmi'

/turf/open/floor/wood/inferno
	icon = 'icons/turf/inferno/if13floors.dmi'
	icon_state = "housewood1"

/turf/open/floor/wood/inferno/Initialize(mapload)
	. = ..()
	if(icon_state == "housewood1")
		icon_state = "housewood[rand(1,4)]"

/turf/open/floor/wood/inferno/setup_broken_states()
	return list("housewood1-broken", "housewood2-broken", "housewood3-broken", "housewood4-broken")

/turf/open/floor/wood/inferno/oak
	icon_state = "oakfloor1"

/turf/open/floor/wood/inferno/oak/Initialize(mapload)
	. = ..()
	if(icon_state == "oakfloor1")
		icon_state = "oakfloor[rand(1,4)]"

/turf/open/floor/wood/inferno/oak/setup_broken_states()
	return list("oakfloor1-broken", "oakfloor2-broken", "oakfloor3-broken", "oakfloor4-broken")