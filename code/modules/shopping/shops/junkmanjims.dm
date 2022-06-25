/obj/machinery/shop_counter/junkmanjims
	store = "Junkman Jim's"
//	bag_icon = "junkmanjims"
	bought_objects = list(
		/obj/item/treasure,
		/obj/item/broken_bottle,
		/obj/item/stack/sheet/animalhide,
		/obj/item/stack/crafting,
		/obj/item/reagent_containers/syringe,
		/obj/item/toy,
		/obj/item/geiger_counter,
		/obj/item/clothing/head/cone,
		/obj/item/food/soylentred,
		/obj/item/dice/d6,
		/obj/item/razor
		)

	shopkeeper_type = /mob/living/simple_animal/snm/interactible/shopkeeper/junkmanjim

	say_purchase = "You're actually buying my junk?"
	say_cant_afford = "I know it's all junk, but you still gotta pay."
	say_sell = "Seems like junk to me. I'll buy it."

/obj/machinery/shop_rack/junkmanjims
	store = "Junkman Jim's"

/mob/living/simple_animal/snm/interactible/shopkeeper/junkmanjim
	name = "Junkman Jim"
	desc = "Catharsis City's leading expert on trash, rubbish, garbage and refuse."
	icon_state = "junkmanjim"
	icon_living = "junkmanjim"
	icon_dead = "junkmanjim"
	taught_skills = list("Scavenging" = 5, "Science" = 5, "Crafting" = 5)