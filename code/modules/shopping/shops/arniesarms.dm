/obj/machinery/shop_counter/arniesarms
	store = "Arnie's Arms"
	bag_icon = "arniesarms"
	sell_modifier = 0.2
	bought_objects = list(
		/obj/item/melee,
		/obj/item/gun
		)

	shopkeeper_type = /mob/living/simple_animal/snm/interactible/shopkeeper/arnie

	say_purchase = "I hope you know how to use it."
	say_cant_afford = "I don't do credit, asshole."
	say_sell = "Yeah, I will take it."

/obj/machinery/shop_rack/arniesarms
	store = "Arnie's Arms"

/obj/machinery/shop_rack/arniesarms/pistols
	icon_state = "pistols"
	goods = list(
		new /datum/data/shopping_good("Ruger MKII",					/obj/item/gun/ballistic/automatic/pistol/ruger,					350),
		new /datum/data/shopping_good("Browning Hi-power",			/obj/item/gun/ballistic/automatic/pistol/browning,				500),
		new /datum/data/shopping_good("M1911",						/obj/item/gun/ballistic/automatic/pistol/m1911,					1000),
		new /datum/data/shopping_good("Double-Barrel Shotgun",		/obj/item/gun/ballistic/shotgun/doublebarrel,					2000),
		)

/obj/machinery/shop_rack/arniesarms/magazines
	icon_state = "magazines"
	goods = list(
		new /datum/data/shopping_good(".38 Speedloader",			/obj/item/ammo_box/c38,							30),
		new /datum/data/shopping_good(".22 Magazine",				/obj/item/ammo_box/magazine/m22,				50),
		new /datum/data/shopping_good("9mm Magazine",				/obj/item/ammo_box/magazine/m9mm,				70),
		new /datum/data/shopping_good(".45 ACP Magazine",			/obj/item/ammo_box/magazine/m45,				75),
		new /datum/data/shopping_good("12 Gauge Buckshot Box",		/obj/item/ammo_box/shotgun/buckshot,			200),
		new /datum/data/shopping_good("12 Gauge Slug Box",			/obj/item/ammo_box/shotgun/slug,				250)
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

/mob/living/simple_animal/snm/interactible/shopkeeper/arnie
	name = "Arnie"
	desc = "Proprietor of Arnie's Arms, named for both his hardware and physique."
	icon_state = "arnie"
	icon_living = "arnie"
	icon_dead = "arnie"
	taught_skills = list("Clubs" = 5, "Blades" = 5, "Guns" = 5, "Dodge" = 5)
	say_greet = "What do you want?"
	say_no_money = "Bullshit. Come back when you have money."
	say_no_exp = "The hell with you."
	say_higher_level = "You know better than me. No, I am not shitting you."
	say_teach = "You wanna be a tough guy? You come to the right place."