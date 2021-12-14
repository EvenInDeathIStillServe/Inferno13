//Fallout 13 neon signs directory

/obj/machinery/light/sign
	name = "bar sign"
	icon_state = "blue"
	base_state = "blue"
	icon = 'icons/obj/neon_signs.dmi'
	bound_width = 64
	fitting = "bulb"
	brightness = 4
	active_power_usage = 0
	density = 0
	desc = "The glow of the sign tempts you to buy a drink..."
	light_color = LIGHT_COLOR_BLUE
	light_type = /obj/item/light/bulb
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF //Destroying these just causes issues. Let's fucking not


/obj/machinery/light/sign/Initialize()
	. = ..()
	AddComponent(/datum/component/largetransparency, x_size = 1, y_size = 1)


/obj/machinery/light/sign/update_icon()
	return

/obj/machinery/light/sign/update()
	return

/obj/machinery/light/sign/process()
	return

/obj/machinery/light/sign/break_light_tube()
	return

/obj/machinery/light/sign/burn_out()
	return

/obj/machinery/light/sign/attackby(obj/item/W, mob/living/user, params) //Uh uh
	return 0

/obj/machinery/light/sign/deconstruct(disassembled = FALSE) //Can't be decosntructed
	return

/obj/machinery/light/sign/attack_hand(mob/living/carbon/human/user) //Fucking nope
	return 0

/obj/machinery/light/sign/explode() //Hell
	return

/obj/machinery/light/sign/kebab
	name = "Kebabtown sign"
	desc = "So awful..."
	icon_state = "Kebab"
	base_state = "Kebab"
	density = TRUE
	light_color = LIGHT_COLOR_YELLOW

/obj/machinery/light/sign/kebab_sign
	name = "Kebabtown"
	desc = "So awful..."
	icon_state = "kebab_sign"
	base_state = "kebab_sign"
	light_color = LIGHT_COLOR_YELLOW

/obj/machinery/light/sign/oasis
	name = "Oasis sign"
	desc = "A sign marking the town of Oasis. It's remarkably fancy."
	icon_state = "Oasis"
	base_state = "Oasis"
	density = TRUE
	light_color = LIGHT_COLOR_YELLOW

/obj/machinery/light/sign/oasis_sign
	name = "Oasis"
	desc = "A sign marking the town of Oasis. It's remarkably fancy.."
	icon_state = "oasis_sign"
	base_state = "oasis_sign"
	light_color = LIGHT_COLOR_YELLOW

/obj/machinery/light/sign/chiken_ranch
	name = "Chiken Ranch sign"
	desc = "Where the west is still wild!"
	icon_state = "chiken_ranch"
	base_state = "chiken_ranch"
	density = TRUE
	light_color = LIGHT_COLOR_PINK

/obj/machinery/light/sign/chudburger_sign
	name = "Chudburger sign"
	desc = "A sign declaring the presence of an establishment that prides itself on making 'edible' food out of chudmeat."
	icon_state = "chudburger"
	base_state = "chudburger"
	light_color = LIGHT_COLOR_YELLOW