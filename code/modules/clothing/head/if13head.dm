/obj/item/clothing/head/helmet/if13/kevlar
	name = "kevlar helmet"
	desc = "A pre-Calamity standard issue camo helmet. Some light scratches dot the surface, but it'll keep your noggin safe. Hopefully."
	icon_state = "kevlar"
	flags_inv = HIDEEARS|HIDEHAIR
	strip_delay = 50
	armor = list("beat" = 9, "slash" = 10, "stab" = 5, "shot" = 16, "enflame" = 5, "electric" = 8, "acid" = 2, "irradiation" = 2, "cold" = 8)
	obj_value = 400

/obj/item/clothing/head/helmet/if13/turnout
	name = "turnout helmet"
	desc = "A firefighter helmet. The light's busted, but your noggin hopefully won't be."
	icon_state = "turnout"
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = list("beat" = 14, "slash" = 10, "stab" = 10, "shot" = 5, "enflame" = 20, "electric" = 16, "acid" = 12, "irradiation" = 5, "cold" = 14)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	resistance_flags = FIRE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	obj_value = 400

/obj/item/clothing/head/helmet/if13/leather
	name = "leather cap"
	desc = "Buhh."
	icon_state = "leather"
	flags_inv = HIDEEARS|HIDEHAIR
	strip_delay = 50
	armor = list("beat" = 16, "slash" = 12, "stab" = 12, "shot" = 12, "enflame" = 5, "electric" = 8, "acid" = 4, "irradiation" = 3, "cold" = 12)
	obj_value = 400

/obj/item/clothing/head/helmet/if13/ronin
	name = "ronin helmet"
	desc = "Buhh."
	icon_state = "ronin"
	flags_inv = HIDEEARS|HIDEHAIR
	armor = list("beat" = 22, "slash" = 22, "stab" = 22, "shot" = 22, "enflame" = 15, "electric" = 12, "acid" = 8, "irradiation" = 3, "cold" = 5)
	obj_value = 800

/obj/item/clothing/head/helmet/if13/acf
	name = "\improper ACF helmet"
	desc = "An advanced military helmet."
	icon_state = "acf"
	flags_inv = HIDEEARS|HIDEHAIR
	armor = list("beat" = 25, "slash" = 25, "stab" = 25, "shot" = 30, "enflame" = 18, "electric" = 18, "acid" = 12, "irradiation" = 6, "cold" = 8)
	obj_value = 1200

/obj/item/clothing/head/helmet/if13/rider
	name = "rider helmet"
	desc = "A motorcycle helmet. It's obviously meant to handle a head-on collision with a truck, so anything less than that should be a breeze."
	icon_state = "rider"
	flags_inv = HIDEEARS|HIDEHAIR
	armor = list("beat" = 28, "slash" = 28, "stab" = 28, "shot" = 25, "enflame" = 20, "electric" = 18, "acid" = 15, "irradiation" = 10, "cold" = 12)
	obj_value = 1200

/obj/item/clothing/head/helmet/if13/light
	flags_inv = 0
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	clothing_flags = SNUG_FIT | PLASMAMAN_HELMET_EXEMPT
	resistance_flags = FIRE_PROOF
	dynamic_hair_suffix = "+generic"
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_range = 4
	light_power = 0.8
	light_on = FALSE

	///Whether the headlamp is on or off.
	var/on = FALSE


/obj/item/clothing/head/helmet/if13/light/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/head/helmet/if13/light/attack_self(mob/living/user)
	toggle_helmet_light(user)

/obj/item/clothing/head/helmet/if13/light/proc/toggle_helmet_light(mob/living/user)
	on = !on
	if(on)
		turn_on(user)
	else
		turn_off(user)
	update_appearance()

/obj/item/clothing/head/helmet/if13/light/update_icon_state()
	inhand_icon_state = "[initial(icon_state)][on ? "_on" : ""]"
	icon_state = inhand_icon_state
	return ..()

/obj/item/clothing/head/helmet/if13/light/proc/turn_on(mob/user)
	set_light_on(TRUE)

/obj/item/clothing/head/helmet/if13/light/proc/turn_off(mob/user)
	set_light_on(FALSE)

/obj/item/clothing/head/helmet/if13/light/hardhat
	name = "hard hat"
	desc = "Safety First! Comes with a WORKING headlamp!"
	icon_state = "hardhat"
	armor = list("beat" = 30, "slash" = 28, "stab" = 28, "shot" = 24, "enflame" = 12, "electric" = 18, "acid" = 15, "irradiation" = 10, "cold" = 8)
	obj_value = 1200