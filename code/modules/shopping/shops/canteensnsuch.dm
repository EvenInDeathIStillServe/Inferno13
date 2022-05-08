/obj/machinery/shop_counter/canteensnsuch
	store = "Canteens 'N Such"
	bag_icon = "canteensnsuch"
	bought_objects = list(
		/obj/item/stack/ore,
		/obj/item/stack/sheet,
		/obj/item/flashlight,
		/obj/item/clothing/mask/gas,
		/obj/item/binoculars)

/obj/machinery/shop_rack/canteensnsuch
	store = "Canteens 'N Such"

/obj/machinery/shop_rack/canteensnsuch/canteens
	icon_state = "canteens"
	goods = list(
		new /datum/data/shopping_good("Green Canteen",			/obj/item/reagent_containers/food/drinks/flask/canteen,			100),
		new /datum/data/shopping_good("Gray Canteen",			/obj/item/reagent_containers/food/drinks/flask/canteen/gray,	100),
		new /datum/data/shopping_good("Piss Canteen",			/obj/item/reagent_containers/food/drinks/flask/canteen/piss,	150)
		)

/obj/machinery/shop_rack/canteensnsuch/tools
	icon_state = "tools"
	goods = list(
		new /datum/data/shopping_good("Shovel",				/obj/item/melee/club/shovel,			220)
		)

/obj/machinery/shop_rack/canteensnsuch/survival
	icon_state = "survival"
	goods = list(
		new /datum/data/shopping_good("Gas Mask",				/obj/item/clothing/mask/gas,									300),
		new /datum/data/shopping_good("Cardboard Box",			/obj/item/storage/box,											100),
		new /datum/data/shopping_good("Satchel",				/obj/item/storage/backpack/satchel/explorer,					200),
		new /datum/data/shopping_good("Flashlight",				/obj/item/flashlight,											150),
		new /datum/data/shopping_good("Heavy-duty Flashlight",	/obj/item/flashlight/seclite,									350),
		new /datum/data/shopping_good("Lantern",				/obj/item/flashlight/lantern,									500),
		new /datum/data/shopping_good("Binoculars",				/obj/item/binoculars,											300),
		new /datum/data/shopping_good("Jerrycan",				/obj/item/reagent_containers/food/drinks/jerrycan,				300),
		new /datum/data/shopping_good("Red Jerrycan",			/obj/item/reagent_containers/food/drinks/jerrycan/red,			300)
		)
