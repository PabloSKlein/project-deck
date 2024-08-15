extends Card

func _init():
	name = "Leather Gloves"
	category = "Armor"
	type = "Armor"
	slot = [CardType.Enum.MAIN_HAND]
	rarity = 0
	magic_multi = 1
	rare_multi = 1.4
	unique_multi = 1.4
	is_dual_handed = false
	image = "gloves"

	var cold_resistance = CardAttibute.new()
	cold_resistance.kind = "Base"
	cold_resistance.name = "Cold Resistance"
	cold_resistance.type = "cold"
	cold_resistance.function = "defense"
	cold_resistance.description = "Increases cold resistance"
	cold_resistance.method = "Increased"
	cold_resistance.icon = "axe"
	cold_resistance.min = 5
	cold_resistance.max = 10

	attributes.append(cold_resistance)
