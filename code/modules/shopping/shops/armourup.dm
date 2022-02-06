/obj/machinery/shop_counter/armourup
	store = "Armour Up"
	bag_icon = "armourup"
	sell_modifier = 0.2
	bought_objects = list(
		/obj/item/clothing/suit/armor/if13,
		/obj/item/clothing/head/helmet/if13,
		/obj/item/clothing/gloves/if13,
		/obj/item/clothing/shoes/if13,
		/obj/item/stack/sheet/animalhide
		)

/obj/machinery/shop_rack/armourup
	store = "Armour Up"

/obj/machinery/shop_rack/armourup/kevlar
	icon_state = "kevlar"
	goods = list(
		new /datum/data/shopping_good("Kevlar Vest",			/obj/item/clothing/suit/armor/if13/kevlar,				600),
		new /datum/data/shopping_good("Kevlar Helmet",			/obj/item/clothing/head/helmet/if13/kevlar,				400),
		new /datum/data/shopping_good("Kevlar Gloves",			/obj/item/clothing/gloves/if13/kevlar,					200),
		new /datum/data/shopping_good("Kevlar Boots",			/obj/item/clothing/shoes/if13/kevlar,					200)
		)

/obj/machinery/shop_rack/armourup/turnout
	icon_state = "turnout"
	goods = list(
		new /datum/data/shopping_good("Turnout Jacket",			/obj/item/clothing/suit/armor/if13/turnout,				600),
		new /datum/data/shopping_good("Turnout Helmet",			/obj/item/clothing/head/helmet/if13/turnout,			400),
		new /datum/data/shopping_good("Turnout Gloves",			/obj/item/clothing/gloves/if13/turnout,					200),
		new /datum/data/shopping_good("Turnout Boots",			/obj/item/clothing/shoes/if13/turnout,					200)
		)

/obj/machinery/shop_rack/armourup/leather
	icon_state = "leather"
	goods = list(
		new /datum/data/shopping_good("Leather Armour",			/obj/item/clothing/suit/armor/if13/leather,				600),
		new /datum/data/shopping_good("Leather Cap",			/obj/item/clothing/head/helmet/if13/leather,			400),
		new /datum/data/shopping_good("Leather Gloves",			/obj/item/clothing/gloves/if13/leather,					200),
		new /datum/data/shopping_good("Leather Boots",			/obj/item/clothing/shoes/if13/leather,					200)
		)

/obj/machinery/shop_rack/armourup/ronin
	icon_state = "ronin"
	goods = list(
		new /datum/data/shopping_good("Ronin Armour",			/obj/item/clothing/suit/armor/if13/ronin,				1200),
		new /datum/data/shopping_good("Ronin Helmet",			/obj/item/clothing/head/helmet/if13/ronin,				800),
		new /datum/data/shopping_good("Ronin Vambraces",		/obj/item/clothing/gloves/if13/ronin,					500),
		new /datum/data/shopping_good("Ronin Tabi",				/obj/item/clothing/shoes/if13/ronin,					500)
		)