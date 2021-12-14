/obj/machinery/shop_counter/chudburger
	store = "Chud Burger"
	bag_icon = "chudburger"
	bought_objects = list(
		/obj/item/food/meat/slab/human/mutant/chud
		)

/obj/machinery/shop_rack/chudburger
	store = "Chud Burger"

/obj/machinery/shop_rack/chudburger/menu
	icon = 'icons/obj/economy.dmi'
	icon_state = "menu"
	goods = list(
		new /datum/data/shopping_good("Chudburger",			/obj/item/food/burger/chud,			50)
		)