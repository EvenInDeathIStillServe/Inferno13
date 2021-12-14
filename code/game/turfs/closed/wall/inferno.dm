/turf/closed/wall/concrete
	name = "concrete wall"
	desc = "A pre-Calamity wall made of solid concrete."
	icon = 'icons/turf/walls/concrete.dmi'
	icon_state = "concrete_wall-0"
	base_icon_state = "concrete_wall"
	baseturfs = /turf/open/indestructible/ground/outside/ruins
	girder_type = 0
	sheet_type = null
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_CONCRETE_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_CONCRETE_WALLS)

/turf/closed/wall/wood/house
	name = "house wall"
	desc = "A weathered pre-Calamity wooden house wall."
	icon = 'icons/turf/walls/house.dmi'
	icon_state = "house-0"
	base_icon_state = "house"
	baseturfs = /turf/open/indestructible/ground/outside/ruins
	girder_type = 0
	sheet_type = null
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_HOUSE_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_HOUSE_WALLS)