/// Halts further checking of any other auras on the mob.
#define AURA_CANCEL (1<<0)
/// Causes the calling `aura_check()` proc to return `FALSE`.
#define AURA_FALSE (1<<1)
// Aura type options for `/mob/living/proc/aura_check()`.
/// Aura checks for projectile impacts. Generally called by `/obj/item/projectile/proc/attack_mob()`. Results in `/obj/aura/proc/aura_check_bullet()`.
#define AURA_TYPE_BULLET "Bullet"
/// Aura checks for physical weapon attacks. Generally called by `/obj/item/proc/use_weapon()`. Results in `/obj/aura/proc/aura_check_weapon()`.
#define AURA_TYPE_WEAPON "Weapon"
/// Aura checks for thrown atom impacts. Generally called by `/mob/living/hitby()`. Results in `/obj/aura/proc/aura_check_thrown()`.
#define AURA_TYPE_THROWN "Thrown"
/// Aura checks during mob life. Generally called by `/mob/living/Life()`. Results in `/obj/aura/proc/aura_check_life()`.
#define AURA_TYPE_LIFE "Life"
#define EMPTY_BITFIELD 0
#define FLAG(BIT) SHIFTL(1, BIT)
