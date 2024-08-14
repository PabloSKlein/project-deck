extends NewCard

func _init():
	name = "Battle Axe"
	category = "Weapon"
	type = "OneHandedAxe"
	slot = [CardType.Enum.MAIN_HAND]
	rarity = 0
	magic_multi = 1
	rare_multi = 1.4
	unique_multi = 1.4
	is_dual_handed = false
	image = "axe"

	var cold_damage = NewCardAttibute.new()
	cold_damage.kind = "Base"
	cold_damage.name = "Cold Damage"
	cold_damage.type = "cold"
	cold_damage.function = "damage"
	cold_damage.description = "Adds cold damage to attacks"
	cold_damage.method = "Added"
	cold_damage.icon = "icon1"
	cold_damage.min = 5
	cold_damage.max = 10
	
	var fire_damage = NewCardAttibute.new()
	cold_damage.kind = "Base"
	cold_damage.name = "Cold Damage"
	cold_damage.type = "cold"
	cold_damage.function = "damage"
	cold_damage.description = "Adds cold damage to attacks"
	cold_damage.method = "Added"
	cold_damage.icon = "icon1"
	cold_damage.min = 5
	cold_damage.max = 10

	attributes.append(cold_damage)
	attributes.append(fire_damage)
