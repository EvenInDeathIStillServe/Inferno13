/obj/machinery/shop_counter/city_hall
	store = "City Hall"
	bag_icon = "city_hall"

	shopkeeper_type = /mob/living/simple_animal/snm/interactible/shopkeeper/city_clerk

	say_purchase = "Make sure to fill out all the forms properly."
	say_cant_afford = "I'm sorry, but I can't waive any fees."

/obj/machinery/shop_rack/city_hall
	store = "City Hall"

/obj/machinery/shop_rack/city_hall/forms
	icon = 'icons/obj/economy.dmi'
	icon_state = "menu"
	goods = list(
		new /datum/data/shopping_good("Business License",			/obj/item/business_license,			1000)
		)

/mob/living/simple_animal/snm/interactible/shopkeeper/city_clerk
	name = "City clerk"
	desc = "A well-dressed looking man. Seems to have a mountain of paperwork to go through."
	icon_state = "city_clerk"
	icon_living = "city_clerk"
	icon_dead = "city_clerk"
	say_greet = "Welcome to city hall. We're all out of pens - damn kleptos - so I hope you brought your own."