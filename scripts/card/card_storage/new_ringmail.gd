extends Card

func _init():
	name = "Ringmail Hauberk"
	category = "Armor"
	type = "Armor"
	slot = [CardType.Enum.BODY]
	rarity = 0
	magic_multi = 1
	rare_multi = 1.4
	unique_multi = 1.4
	is_dual_handed = false
	image = "armor"

	var fire_resistance = CardAttibute.new()
	fire_resistance.kind = "Base"
	fire_resistance.name = "Fire Resistance"
	fire_resistance.type = "fire"
	fire_resistance.function = "defense"
	fire_resistance.description = "Increases fire resistance"
	fire_resistance.method = "Increased"
	fire_resistance.icon = "axe"
	fire_resistance.min = 5
	fire_resistance.max = 10

	attributes.append(fire_resistance)
