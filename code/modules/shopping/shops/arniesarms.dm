/obj/machinery/shop_counter/arniesarms
	store = "Arnie's Arms"
	bag_icon = "arniesarms"
	bought_objects = list(
		/obj/item/melee,
		/obj/item/gun
		)

/obj/machinery/shop_rack/arniesarms
	store = "Arnie's Arms"

/obj/machinery/shop_rack/arniesarms/pistols
	icon_state = "pistols"
	goods = list(
		new /datum/data/shopping_good("Ruger MKII",					/obj/item/gun/ballistic/automatic/pistol/ruger,					150),
		new /datum/data/shopping_good("Browning Hi-power",			/obj/item/gun/ballistic/automatic/pistol/browning,				200),
		new /datum/data/shopping_good("M1911",						/obj/item/gun/ballistic/automatic/pistol/m1911,					300)
		)

/obj/machinery/shop_rack/arniesarms/magazines
	icon_state = "magazines"
	goods = list(
		new /datum/data/shopping_good(".38 Speedloader",			/obj/item/ammo_box/c38,							20),
		new /datum/data/shopping_good(".22 Magazine",				/obj/item/ammo_box/magazine/m22,				30),
		new /datum/data/shopping_good("9mm Magazine",				/obj/item/ammo_box/magazine/m9mm,				70),
		new /datum/data/shopping_good(".45 ACP Magazine",			/obj/item/ammo_box/magazine/m45,				80)
		)

/obj/machinery/shop_rack/arniesarms/clubs
	icon_state = "clubs"
	goods = list(
		new /datum/data/shopping_good("Baseball Bat",				/obj/item/melee/club/baseball_bat,				200),
		new /datum/data/shopping_good("Crowbar",					/obj/item/melee/club/crowbar,					250)
		)

/obj/machinery/shop_rack/arniesarms/blades
	icon_state = "blades"
	goods = list(
		new /datum/data/shopping_good("Kitchen Knife",				/obj/item/melee/blade/kitchen_knife,			150)
		)