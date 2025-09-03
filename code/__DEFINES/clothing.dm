/*
//stages of shoe tying-ness
/// Shoes are untied
#define SHOES_UNTIED 0
/// Shoes are tied normally
#define SHOES_TIED 1
/// Shoes have been tied in knots
#define SHOES_KNOTTED 2

//suit sensors: sensor_mode defines
/// Suit sensor is turned off
#define SENSOR_OFF 0
/// Suit sensor displays the mob as alive or dead
#define SENSOR_LIVING 1
/// Suit sensor displays the mob damage values
#define SENSOR_VITALS 2
/// Suit sensor displays the mob damage values and exact location
#define SENSOR_COORDS 3

//suit sensors: has_sensor defines
/// Suit sensor has been EMP'd and cannot display any information (can be fixed)
#define BROKEN_SENSORS -1
/// Suit sensor is not present and cannot display any information
#define NO_SENSORS 0
/// Suit sensor is present and can display information
#define HAS_SENSORS 1
/// Suit sensor is present and is forced to display information (used on prisoner jumpsuits)
#define LOCKED_SENSORS 2
*/

/// Wrapper for adding clothing based traits
#define ADD_CLOTHING_TRAIT(mob, trait) ADD_TRAIT(mob, trait, "[CLOTHING_TRAIT]_[REF(src)]")
/// Wrapper for removing clothing based traits
#define REMOVE_CLOTHING_TRAIT(mob, trait) REMOVE_TRAIT(mob, trait, "[CLOTHING_TRAIT]_[REF(src)]")

/*
/// How much integrity does a shirt lose every time we bite it?
#define MOTH_EATING_CLOTHING_DAMAGE 15
*/

// Base equipment delays
/// Delay base for full-body coverage suit slot items. (hardsuits, spacesuits, radsuits, etc.)
#define EQUIP_DELAY_OVERSUIT (6 SECONDS)

/// Delay base for suit slot items
#define EQUIP_DELAY_SUIT (4 SECONDS)

/// Delay base for hard-body shoes and boots.
#define EQUIP_DELAY_BOOTS (2 SECONDS)
/// Delay base for hard-body, strapped, or otherwise head-covering hats.
#define EQUIP_DELAY_HELMET (2 SECONDS)
/// Delay base for shoes.
#define EQUIP_DELAY_SHOES (2 SECONDS)
/// Delay base for suit and cloak slot items that are trivially removed or put on. (Coats, Jackets, Ponchos, etc.)
#define EQUIP_DELAY_COAT (2 SECONDS)
/// Delay base for Undersuits.
#define EQUIP_DELAY_UNDERSUIT (2 SECONDS)

/// Delay base for masks.
#define EQUIP_DELAY_MASK (1 SECONDS)
/// Delay base for back-worn objects.
#define EQUIP_DELAY_BACK (1 SECONDS)
/// Delay base for belts.
#define EQUIP_DELAY_BELT (1 SECONDS)
/// Delay base for hats.
#define EQUIP_DELAY_HAT (1 SECONDS)
/// Delay base for gloves.
#define EQUIP_DELAY_GLOVES (1 SECONDS)
/// Delay base for glasses.
#define EQUIP_DELAY_EYEWEAR (1 SECONDS)

// Flags for self equipping items
/// Allow movement during equip/unequip
#define EQUIP_ALLOW_MOVEMENT (1<<0)
/// Apply a slowdown when equipping or unequipping.
#define EQUIP_SLOWDOWN (1<<1)

//sound defines for equipping and unequipping
#define EQUIP_SOUND_VFAST_GENERIC 'sound/items/equip/equipping_vfast_generic.ogg'
#define UNEQUIP_SOUND_VFAST_GENERIC 'sound/items/equip/unequipping_vfast_generic.ogg'

#define EQUIP_SOUND_SHORT_GENERIC 'sound/items/equip/equipping_short_generic.ogg'
#define UNEQUIP_SOUND_SHORT_GENERIC 'sound/items/equip/unequipping_short_generic.ogg'

#define EQUIP_SOUND_MED_GENERIC 'sound/items/equip/equipping_med_generic.ogg'
#define UNEQUIP_SOUND_MED_GENERIC 'sound/items/equip/unequipping_med_generic.ogg'

#define EQUIP_SOUND_LONG_GENERIC 'sound/items/equip/equipping_long_generic.ogg'
#define UNEQUIP_SOUND_LONG_GENERIC 'sound/items/equip/unequipping_long_generic.ogg'

#define COLOR_VARIANTS_HELPER(basepath, item_name) \
/obj/item/clothing/##basepath/white { \
	name = "white " + ##item_name; \
	icon_state = "white"; \
	current_skin = "white " + ##item_name; \
} \
/obj/item/clothing/##basepath/grey { \
	name = "grey " + ##item_name; \
	icon_state = "grey"; \
	current_skin = "grey " + ##item_name; \
} \
/obj/item/clothing/##basepath/black { \
	name = "black " + ##item_name; \
	icon_state = "black"; \
	current_skin = "black " + ##item_name; \
} \
/obj/item/clothing/##basepath/red { \
	name = "red " + ##item_name; \
	icon_state = "red"; \
	current_skin = "red " + ##item_name; \
} \
/obj/item/clothing/##basepath/maroon { \
	name = "maroon " + ##item_name; \
	icon_state = "maroon"; \
	current_skin = "maroon " + ##item_name; \
} \
/obj/item/clothing/##basepath/orange { \
	name = "orange " + ##item_name; \
	icon_state = "orange"; \
	current_skin = "orange " + ##item_name; \
} \
/obj/item/clothing/##basepath/yellow { \
	name = "yellow " + ##item_name; \
	icon_state = "yellow"; \
	current_skin = "yellow " + ##item_name; \
} \
/obj/item/clothing/##basepath/green { \
	name = "green " + ##item_name; \
	icon_state = "green"; \
	current_skin = "green " + ##item_name; \
} \
/obj/item/clothing/##basepath/darkgreen { \
	name = "dark green " + ##item_name; \
	icon_state = "darkgreen"; \
	current_skin = "dark green " + ##item_name; \
} \
/obj/item/clothing/##basepath/teal { \
	name = "teal " + ##item_name; \
	icon_state = "teal"; \
	current_skin = "teal " + ##item_name; \
} \
/obj/item/clothing/##basepath/blue { \
	name = "blue " + ##item_name; \
	icon_state = "blue"; \
	current_skin = "blue " + ##item_name; \
} \
/obj/item/clothing/##basepath/darkblue { \
	name = "dark blue " + ##item_name; \
	icon_state = "darkblue"; \
	current_skin = "dark blue " + ##item_name; \
} \
/obj/item/clothing/##basepath/purple { \
	name = "purple " + ##item_name; \
	icon_state = "purple"; \
	current_skin = "purple " + ##item_name; \
} \
/obj/item/clothing/##basepath/pink { \
	name = "pink " + ##item_name; \
	icon_state = "pink"; \
	current_skin = "pink " + ##item_name; \
} \
/obj/item/clothing/##basepath/brown { \
	name = "brown " + ##item_name; \
	icon_state = "brown"; \
	current_skin = "brown " + ##item_name; \
} \
/obj/item/clothing/##basepath/lightbrown { \
	name = "light brown " + ##item_name; \
	icon_state = "lightbrown"; \
	current_skin = "light brown " + ##item_name; \
}

#define UNIQUE_RESKIN_HELPER(item_name) \
unique_reskin = list( \
	"white " + ##item_name = "white", \
	"grey " + ##item_name = "grey", \
	"black " + ##item_name = "black", \
	"red " + ##item_name = "red", \
	"maroon " + ##item_name = "maroon", \
	"orange " + ##item_name = "orange", \
	"yellow " + ##item_name = "yellow", \
	"green " + ##item_name = "green", \
	"dark green " + ##item_name = "darkgreen", \
	"teal " + ##item_name = "teal", \
	"blue " + ##item_name = "blue", \
	"dark blue " + ##item_name = "darkblue", \
	"purple " + ##item_name = "purple", \
	"pink " + ##item_name = "pink", \
	"brown " + ##item_name = "brown", \
	"light brown " + ##item_name = "lightbrown" \
)
