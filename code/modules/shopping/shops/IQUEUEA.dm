/obj/structure/furniture_model
	name = "display model"
	desc = "A display model for a piece of furniture. There's a bunch of PackIt! packits hidden conveniently behind it."

	icon = 'icons/obj/shop_rack.dmi'
	icon_state = "table"

	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	can_be_unanchored = FALSE
	layer = BELOW_OBJ_LAYER

	var/sold_packit
	var/price

/obj/structure/furniture_model/examine(mob/user)
	. = ..()
	. += "<span class='notice'>It costs <b>$[price]</b>.</span>"

/obj/structure/furniture_model/attack_hand(mob/living/carbon/human/user, list/modifiers)
	if (!user)
		return
	to_chat(usr, span_notice("You start picking up a packit for [src]."))
	if (do_after(usr, 2 SECONDS, target = src))
		if (!user.canpay(price))
			to_chat(user, "<span class='warning'>Your credchip beeps sadly, and you retract your hand out of shame.</span>")
			return
		user.payact(-price)
		var/obj/item/packit/packit = new sold_packit(src.loc)
		user.put_in_hands(packit)
		to_chat(user, span_notice("Your credchip automatically registers the purchase as you pick up [packit]."))
		return TRUE

/obj/structure/furniture_model/table
	name = "table"
	icon_state = "table"
	sold_packit = /obj/item/packit/table
	price = 500

/obj/structure/furniture_model/wooden_table
	name = "wooden table"
	icon_state = "wood_table"
	sold_packit = /obj/item/packit/table/wood
	price = 700

/obj/structure/furniture_model/chair
	name = "chair"
	icon_state = "chair"
	sold_packit = /obj/item/packit/chair
	price = 300

/obj/structure/furniture_model/wooden_chair
	name = "wooden chair"
	icon_state = "wood_chair"
	sold_packit = /obj/item/packit/chair/wood
	price = 400

/obj/structure/furniture_model/bed
	name = "bed"
	icon_state = "bed"
	sold_packit = /obj/item/packit/bed
	price = 750

/obj/structure/furniture_model/closet
	name = "closet"
	icon_state = "closet"
	sold_packit = /obj/item/packit/closet
	price = 500

/obj/structure/furniture_model/crate
	name = "crate"
	icon_state = "crate"
	sold_packit = /obj/item/packit/crate
	price = 500

/obj/structure/packitcart_dispenser
	name = "packit cart dispenser"
	desc = "An array of packit carts, ripe for the taking... as long as you pay the $250 deposit fee, recoverable when you return the cart."

	icon = 'icons/obj/packit.dmi'
	icon_state = "cart_dispenser"

	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	can_be_unanchored = FALSE
	layer = BELOW_OBJ_LAYER

/obj/structure/packitcart_dispenser/attack_hand(mob/living/carbon/human/user, list/modifiers)
	if (!user)
		return
	to_chat(usr, span_notice("You start pulling a cart out of [src]."))
	if (do_after(usr, 2 SECONDS, target = src))
		if (!user.canpay(250))
			to_chat(user, "<span class='warning'>Your credchip beeps sadly, and you retract your hand out of shame.</span>")
			return
		user.payact(-250)
		var/obj/item/packit/packit = new /obj/structure/packitcart(user.loc)
		user.start_pulling(packit)
		to_chat(user, span_notice("Your credchip automatically registers the purchase as you pull out [packit]."))
		return TRUE

/obj/structure/packitcart_dispenser/MouseDrop_T(obj/structure/packitcart/cart, mob/living/carbon/human/user)
	if (!user)
		return
	if (istype(cart))
		if (cart.contents.len)
			to_chat(user, "<span class='warning'>[cart] is still loaded! Unload it first.</span>")
			return
		user.payact(250)
		to_chat(user, span_notice("You return the cart and receive the deposit for it."))
		user.award_journal(/datum/journal/packitcarttheory)
		qdel(cart)