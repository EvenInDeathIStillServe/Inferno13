/obj/machinery/menu/skumm
	name = "\improper Skumm Bar menu"

	drinks = list(
		new /datum/data/bar_drink("Water",			/datum/reagent/water,									10),
		new /datum/data/bar_drink("Beer",			/datum/reagent/consumable/ethanol/beer,					20),
		new /datum/data/bar_drink("Vodka",			/datum/reagent/consumable/ethanol/vodka,				40),
		new /datum/data/bar_drink("Whiskey",		/datum/reagent/consumable/ethanol/whiskey,				50),
		new /datum/data/bar_drink("Rum",			/datum/reagent/consumable/ethanol/rum,					50),
		new /datum/data/bar_drink("Wine",			/datum/reagent/consumable/ethanol/wine,					70),
		new /datum/data/bar_drink("Grog",			/datum/reagent/consumable/ethanol/grog,					100)
		)

	foods = list(
		new /datum/data/bar_food("Donut",			/obj/item/food/donut,				30),
		new /datum/data/bar_food("Fries",			/obj/item/food/fries,				50),
		new /datum/data/bar_food("Hotdog",			/obj/item/food/hotdog,				70),
		new /datum/data/bar_food("Hamburger",		/obj/item/food/burger/plain,			90),
		new /datum/data/bar_food("Cheeseburger",	/obj/item/food/burger/cheese,			100)
		)