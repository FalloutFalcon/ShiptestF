// Tool types
#define TOOL_CROWBAR "crowbar"
#define TOOL_MULTITOOL "multitool"
#define TOOL_SCREWDRIVER "screwdriver"
#define TOOL_WIRECUTTER "wirecutter"
#define TOOL_WRENCH "wrench"
#define TOOL_WELDER "welder"
#define TOOL_ANALYZER "analyzer"
#define TOOL_MINING "mining"
#define TOOL_SHOVEL "shovel"
#define TOOL_RETRACTOR "retractor"
#define TOOL_HEMOSTAT "hemostat"
#define TOOL_CAUTERY "cautery"
#define TOOL_DRILL "drill"
#define TOOL_SCALPEL "scalpel"
#define TOOL_SAW "saw"
#define TOOL_KNIFE "knife" //luv me kuh-nyfe
#define TOOL_DECONSTRUCT "deconstruct"

#define QUALITY_BOLT_TURNING			"bolt turning"
#define QUALITY_PULSING					"pulsing"
#define QUALITY_PRYING					"prying"
#define QUALITY_WELDING					"welding"
#define QUALITY_SCREW_DRIVING			"screw driving"
#define QUALITY_WIRE_CUTTING			"wire cutting"
#define QUALITY_CLAMPING				"clamping"
#define QUALITY_CAUTERIZING				"cauterizing"
#define QUALITY_RETRACTING				"retracting"
#define QUALITY_DRILLING				"drilling"
#define QUALITY_HAMMERING				"hammering"
#define QUALITY_SAWING					"sawing"
#define QUALITY_BONE_SETTING			"bone setting"
#define QUALITY_SHOVELING				"shoveling"
#define QUALITY_DIGGING					"digging"
#define QUALITY_EXCAVATION				"excavation"
#define QUALITY_CUTTING					"cutting"
#define QUALITY_LASER_CUTTING			"laser cutting"	//laser scalpels and e-swords - bloodless cutting
#define QUALITY_ADHESIVE				"adhesive"
#define QUALITY_SEALING					"sealing"

// If delay between the start and the end of tool operation is less than MIN_TOOL_SOUND_DELAY,
// tool sound is only played when op is started. If not, it's played twice.
#define MIN_TOOL_SOUND_DELAY 20

/// When a tooltype_act proc is successful
#define TOOL_ACT_TOOLTYPE_SUCCESS (1<<0)
/// When [COMSIG_ATOM_TOOL_ACT] blocks the act
#define TOOL_ACT_SIGNAL_BLOCKING (1<<1)
