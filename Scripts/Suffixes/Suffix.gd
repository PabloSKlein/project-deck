extends Node

class_name Suffix

enum SuffixesType {HEALTH_ON_KILL, CHANCE_BLEED_HIT, CHANCE_CHILL_HIT}

@export var type: SuffixesType
@export var tier: int
@export var bonus: float

# Class variable to store suffix names
static var suffix_names = {
	SuffixesType.HEALTH_ON_KILL: ["Phoenix", "Dragon", "Titan", "Mystic", "Eternal"],
	SuffixesType.CHANCE_BLEED_HIT: ["Bleed", "Tear", "Pierce", "Wound", "Rupture"],
	SuffixesType.CHANCE_CHILL_HIT: ["Frost", "Freeze", "Chill", "Ice", "Glacier"]
}

var tier_ranges = {
	SuffixesType.HEALTH_ON_KILL: {
		1: { "min": 10, "max": 21 },
		2: { "min": 23, "max": 37 },
		3: { "min": 38, "max": 52 },
		4: { "min": 54, "max": 68 },
		5: { "min": 70, "max": 105 }
	},
	SuffixesType.CHANCE_BLEED_HIT: {
		1: { "min": 5, "max": 10 },
		2: { "min": 11, "max": 20 },
		3: { "min": 21, "max": 30 },
		4: { "min": 31, "max": 40 },
		5: { "min": 41, "max": 60 }
	},
	SuffixesType.CHANCE_CHILL_HIT: {
		1: { "min": 1.1, "max": 1.2 },
		2: { "min": 1.3, "max": 1.4 },
		3: { "min": 1.5, "max": 1.6 },
		4: { "min": 1.7, "max": 1.8 },
		5: { "min": 1.9, "max": 2.0 }
	}
}

func _init(type: SuffixesType, tier: int):
	self.type = type
	self.tier = tier
	self.bonus = _generate_random_bonus(type, tier)

func _generate_random_bonus(type: SuffixesType, tier: int) -> float:
	var range = tier_ranges.get(type, {}).get(tier, { "min": 0, "max": 0 })
	return randf_range(range["min"], range["max"])

func get_description() -> String:
	var type_name = ""
	match type:
		SuffixesType.HEALTH_ON_KILL:
			type_name = "Health on Kill"
		SuffixesType.CHANCE_BLEED_HIT:
			type_name = "Chance to Bleed Hit"
		SuffixesType.CHANCE_CHILL_HIT:
			type_name = "Chance to Chill Hit"
	return type_name + " Tier " + str(tier) + " (Bonus: " + str(bonus) + ")"

# Static method to get suffix names based on type
static func get_suffix_names(type: SuffixesType) -> Array:
	return suffix_names.get(type, [])
