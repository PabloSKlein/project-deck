extends Node

class_name Prefix

enum PrefixType {COLD_DAMAGE, CRITICAL_STRIKE_CHANCE, CRITICAL_STRIKE_MULTIPLIER}

# Define the type of prefix and its tiers
@export var type: PrefixType
@export var tier: int
@export var bonus: float

# Define tiers and their ranges
var tier_ranges = {
	PrefixType.COLD_DAMAGE: {
		1: { "min": 10, "max": 21 },
		2: { "min": 23, "max": 37 },
		3: { "min": 38, "max": 52 },
		4: { "min": 54, "max": 68 },
		5: { "min": 70, "max": 105 }
	},
	PrefixType.CRITICAL_STRIKE_CHANCE: {
		1: { "min": 5, "max": 10 },
		2: { "min": 11, "max": 20 },
		3: { "min": 21, "max": 30 },
		4: { "min": 31, "max": 40 },
		5: { "min": 41, "max": 60 }
	},
	PrefixType.CRITICAL_STRIKE_MULTIPLIER: {
		1: { "min": 1.1, "max": 1.2 },
		2: { "min": 1.3, "max": 1.4 },
		3: { "min": 1.5, "max": 1.6 },
		4: { "min": 1.7, "max": 1.8 },
		5: { "min": 1.9, "max": 2.0 }
	}
}

func _init(type: PrefixType, tier: int):
	self.type = type
	self.tier = tier
	self.bonus = _generate_random_bonus(type, tier)

func _generate_random_bonus(type: PrefixType, tier: int) -> float:
	var range = tier_ranges.get(type, {}).get(tier, { "min": 0, "max": 0 })
	return randf_range(range["min"], range["max"])

func get_description() -> String:
	return str(type) + " Tier " + str(tier) + " (Bonus: " + str(bonus) + ")"
