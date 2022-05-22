/obj/item/packit
	name = "packit"
	desc = "A PackIt! container. Contains all you need to assemble your furniture in a timely manner."
	icon = 'icons/obj/packit.dmi'
	icon_state = "packit"
	w_class = WEIGHT_CLASS_BULKY
	var/furniture_type //The deployed furniture path


/obj/item/packit/attack_self(mob/living/carbon/human/user)
	if (!user)
		return
	if (!furniture_type)
		return
	if (!isturf(user.loc))
		return
	var/area/our_area = get_area(user.loc)
	if (our_area.area_flags & FURNITURE_DEPLOYABLE)
		if (locate(furniture_type) in user.loc)
			to_chat(user, span_warning("There's already a furniture of this type here!"))
		if (!user.temporarilyRemoveItemFromInventory(src))
			return
		var/obj/furniture = new furniture_type(user.loc)
		user.visible_message("<span class='notice'>[user] assembles \a [furniture].\
			</span>", span_notice("You assemble \a [furniture]."))
		furniture.add_fingerprint(user)
		furniture.packit_type = src.type
		furniture.dir = user.dir
		qdel(src)

/obj/item/packit/table
	name = "packit (table)"
	icon_state = "table"
	furniture_type = /obj/structure/table

/obj/item/packit/table/wood
	name = "packit (wooden table)"
	furniture_type = /obj/structure/table/wood

/obj/item/packit/chair
	name = "packit (chair)"
	icon_state = "chair"
	furniture_type = /obj/structure/chair

/obj/item/packit/chair/wood
	name = "packit (wooden chair)"
	furniture_type = /obj/structure/chair/wood

/obj/item/packit/bed
	name = "packit (bed)"
	icon_state = "bed"
	furniture_type = /obj/structure/bed

/obj/item/packit/closet
	name = "packit (closet)"
	icon_state = "closet"
	furniture_type = /obj/structure/closet

/obj/item/packit/crate
	name = "packit (crate)"
	icon_state = "crate"
	furniture_type = /obj/structure/closet/crate

/obj/structure/packitcart
	name = "packit cart"
	desc = "A trolley cart designed specially for handling PackIt! packits."
	icon = 'icons/obj/packit.dmi'
	icon_state = "cart"
	anchored = FALSE
	density = TRUE

/obj/structure/packitcart/attackby(obj/item/I, mob/user, params)
	if (istype(I, /obj/item/packit))
		if (contents.len >= 6)
			to_chat(user, span_warning("[src] is already at maximum capacity!"))
			return
		if(!user.transferItemToLoc(I, src))
			return
		to_chat(user, span_notice("You load [I] onto [src]."))
		update_appearance()
	else
		return ..()

/obj/structure/packitcart/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return

	if (!contents.len)
		return

	var/list/items = list()
	for (var/obj/item/packit/packit in contents)
		items[packit] = icon(packit.icon, packit.icon_state)

	if(!length(items))
		return
	items = sort_list(items)
	var/obj/item/packit/pick = show_radial_menu(user, src, items, custom_check = CALLBACK(src, .proc/check_interactable, user), radius = 38, require_near = TRUE)
	if(!pick)
		return
	user.put_in_hands(pick)
	to_chat(user, span_notice("You unload [pick] from [src]."))
	update_appearance()

/obj/structure/packitcart/proc/check_interactable(mob/living/carbon/human/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/structure/packitcart/update_overlays()
	. = ..()
	if (contents.len)
		. += "box_[min(contents.len,6)]"