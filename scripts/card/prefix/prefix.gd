class_name Prefix extends Node

enum PrefixType {COLD_DAMAGE, FIRE_DAMAGE, LIGHTNING_DAMAGE}

@export var type: PrefixType
@export var tier: int
@export var bonus: float

# Class variable to store prefix names
static var prefix_names = {
	PrefixType.COLD_DAMAGE: ["Frostbite", "Ice", "Glacial", "Chill", "Snow"],
	PrefixType.FIRE_DAMAGE: ["Inferno", "Blaze", "Flame", "Scorch", "Ember"],
	PrefixType.LIGHTNING_DAMAGE: ["Shock", "Thunder", "Bolt", "Storm", "Flash"]
}

var tier_ranges = {
	PrefixType.COLD_DAMAGE: {
		1: { "min": 5, "max": 10 },
		2: { "min": 11, "max": 20 },
		3: { "min": 21, "max": 30 },
		4: { "min": 31, "max": 40 },
		5: { "min": 41, "max": 60 }
	},
	PrefixType.FIRE_DAMAGE: {
		1: { "min": 8, "max": 15 },
		2: { "min": 16, "max": 25 },
		3: { "min": 26, "max": 35 },
		4: { "min": 36, "max": 45 },
		5: { "min": 46, "max": 70 }
	},
	PrefixType.LIGHTNING_DAMAGE: {
		1: { "min": 6, "max": 12 },
		2: { "min": 13, "max": 22 },
		3: { "min": 23, "max": 32 },
		4: { "min": 33, "max": 42 },
		5: { "min": 43, "max": 65 }
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
	var type_name = ""
	match type:
		PrefixType.COLD_DAMAGE:
			type_name = "Cold Damage"
		PrefixType.FIRE_DAMAGE:
			type_name = "Fire Damage"
		PrefixType.LIGHTNING_DAMAGE:
			type_name = "Lightning Damage"
	return type_name + " Tier " + str(tier) + " (Bonus: " + str(snapped(bonus,0.01)) + ")"

func getId() -> String:
	match type:
		PrefixType.COLD_DAMAGE:
			return "Cold Damage"
		PrefixType.FIRE_DAMAGE:
			return "Fire Damage"
		PrefixType.LIGHTNING_DAMAGE:
			return "Lightning Damage"
	return "Other"

# Static method to get prefix names based on type
static func get_prefix_names(type: PrefixType) -> Array:
	return prefix_names.get(type, [])
