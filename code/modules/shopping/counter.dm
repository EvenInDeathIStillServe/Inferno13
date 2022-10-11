/obj/machinery/shop_counter
	name = "shop counter"
	desc = "This is where you pay for and pick up your order. Keep your creditchip handy!"

	icon = 'icons/obj/economy.dmi'
	icon_state = "counter"

	anchored = TRUE
	density = FALSE
	use_power = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	can_be_unanchored = FALSE
	layer = BELOW_OBJ_LAYER

	var/store
	var/bag_icon

	///How much of the value the shop pays for items
	var/sell_modifier = 1
	var/list/bought_objects = list()
	var/list/unwanted_objects = list()
	var/list/bought_reagents = list()
	var/list/unwanted_reagents = list()
	var/mob/living/simple_animal/snm/interactible/shopkeeper/shopkeeper
	var/shopkeeper_type

	var/speech_time
	var/say_purchase = "Thanks for stopping by."
	var/say_cant_afford = "You can't afford it."
	var/say_sell = "I'll take that off your hands."
	var/say_no_sell = "Not interested."

/obj/machinery/shop_counter/Initialize(mapload)
	. = ..()
	if (!shopkeeper_type)
		return
	for (var/mob/living/simple_animal/snm/interactible/shopkeeper/S in range(5,src))
		if (istype(S, shopkeeper_type))
			shopkeeper = S
			break

/obj/machinery/shop_counter/attackby(obj/item/W, mob/living/carbon/human/user, params)
	if (!user)
		return
	if (istype(W, /obj/item/shopping_card))
		var/obj/item/shopping_card/card = W
		if (card.store != store)
			to_chat(usr, "<span class='warning'>This card is for another store! You look like a real fool.</span>")
			return
		if (!user.canpay(card.total) && !card.prepaid)
			speech(say_cant_afford)
			to_chat(usr, "<span class='warning'>You can't afford it.</span>")
			return
		to_chat(usr, "<span class='notice'>You pay for your purchase and get a bag with your stuff inside.</span>")
		if (!card.prepaid)
			user.payact(-card.total, store)
		var/obj/item/storage/box/shopping_bag/bag = new /obj/item/storage/box/shopping_bag(loc)
		for (var/list/entry in card.goods)
			var/path = entry["item_path"]
			for (var/i = 0, i<entry["quantity"], i++)
				new path(bag)
		bag.illustration = bag_icon
		bag.update_icon()
		qdel(card)
		speech(say_purchase)
		user.put_in_active_hand(bag)
		user.award_journal(/datum/journal/capitalismho)
	else
		var/sale_value = try_sell(W, user)
		if (sale_value > 0)
			user.payact(sale_value, store)
			speech(say_sell)
		else
			speech(say_no_sell)

/obj/machinery/shop_counter/proc/try_sell(obj/item/W, mob/living/carbon/human/user, bulk = FALSE)
	if (istype(W, /obj/item/storage))
		var/total_value = 0
		for (var/obj/item/thing in W)
			total_value += try_sell(thing, user, TRUE)
		to_chat(user, "<span class='notice'>You present the contents of [W].</span>")
		return total_value
	if (bought_reagents.len && istype(W, /obj/item/reagent_containers))
		var/reagents_value
		var/obj/item/reagent_containers/container = W
		for (var/datum/reagent/reagent in container.reagents.reagent_list)
			if (unwanted_reagents && is_type_in_list(reagent, unwanted_reagents))
				continue
			if (is_type_in_list(reagent, bought_reagents))
				reagents_value += reagent.volume * reagent.reagent_value
		if (reagents_value < 1)
			if (!bulk)
				to_chat(usr, "<span class='warning'>[W] is worthless.</span>")
			return
		special_sell(container, user)
		to_chat(user, "<span class='notice'>You sell [W].</span>")
		qdel(container)
		return reagents_value
	if (bought_objects.len)
		if (!W.get_obj_value())
			if (!bulk)
				to_chat(usr, "<span class='warning'>[W] is worthless.</span>")
			return
		if (!(is_type_in_list(W, bought_objects)) || (unwanted_objects && is_type_in_list(W, unwanted_objects)))
			if (!bulk)
				to_chat(usr, "<span class='warning'>This shop isn't interested in [W].</span>")
			return
		special_sell(W, user)
		var/sell_value = round(W.get_obj_value() * sell_modifier)
		to_chat(user, "<span class='notice'>You sell [W].</span>")
		qdel(W)
		return sell_value

/obj/machinery/shop_counter/proc/special_sell(obj/item/W, mob/living/carbon/human/user)
	return

/obj/machinery/shop_counter/proc/speech(speech_line)
	if (!shopkeeper)
		return
	if (speech_time <= world.time)
		shopkeeper.say(speech_line)
		speech_time = world.time + 5 SECONDS