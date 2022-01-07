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
	var/mob/living/simple_animal/snm/interactible/shopkeeper/shopkeeper
	var/shopkeeper_type

	var/speech_time
	var/say_purchase = "Thanks for stopping by."
	var/say_cant_afford = "You can't afford it."
	var/say_sell = "I'll take that off your hands."

/obj/machinery/shop_counter/Initialize(mapload)
	. = ..()
	if (!shopkeeper_type)
		return
	for (var/mob/living/simple_animal/snm/interactible/shopkeeper/S in range(5,src))
		if (istype(S, shopkeeper_type))
			shopkeeper = S
			return

/obj/machinery/shop_counter/attackby(obj/item/W, mob/user, params)
	if (!(ishuman(user)))
		return
	if (istype(W, /obj/item/shopping_card))
		var/obj/item/shopping_card/card = W
		if (card.store != store)
			to_chat(usr, "<span class='warning'>This card is for another store! You look like a real fool.</span>")
			return
		if (!user:canpay(card.total) && !card.prepaid)
			speech(say_cant_afford)
			to_chat(usr, "<span class='warning'>You can't afford it.</span>")
			return
		to_chat(usr, "<span class='notice'>You pay for your purchase and get a bag with your stuff inside.</span>")
		if (!card.prepaid)
			user:payact(-card.total)
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
	else if (can_buy(W))
		to_chat(user, "<span class='notice'>You sell [W].</span>")
		user:payact(round(W.get_obj_value() * sell_modifier))
		speech(say_sell)
		qdel(W)

/obj/machinery/shop_counter/proc/can_buy(obj/item/W)
	if (bought_objects.len)
		if (!W.get_obj_value())
			to_chat(usr, "<span class='warning'>[W] is worthless.</span>")
			return
		if (!(is_type_in_list(W, bought_objects)) || (unwanted_objects && is_type_in_list(W, unwanted_objects)))
			to_chat(usr, "<span class='warning'>This shop isn't interested in [W].</span>")
			return
		return TRUE

/obj/machinery/shop_counter/proc/speech(speech_line)
	if (!shopkeeper)
		return
	if (speech_time <= world.time)
		shopkeeper.say(speech_line)
		speech_time = world.time + 5 SECONDS