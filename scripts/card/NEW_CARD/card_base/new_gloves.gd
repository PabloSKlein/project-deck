extends NewCard

func _init():
	name = "Leather Gloves"
	category = "Armor"
	type = "Armor"
	slot = ["Gloves"]
	rarity = ""
	magic_multi = 1
	rare_multi = 1.4
	unique_multi = 1.4
	is_dual_handed = false
	image = "gloves"

	var cold_resistance = NewCardAttibute.new()
	cold_resistance.kind = "Base"
	cold_resistance.name = "Cold Resistance"
	cold_resistance.type = "cold"
	cold_resistance.function = "defense"
	cold_resistance.description = "Increases cold resistance"
	cold_resistance.method = "Increased"
	cold_resistance.icon = "icon1"
	cold_resistance.min = 5
	cold_resistance.max = 10

	attributes.append(cold_resistance)
