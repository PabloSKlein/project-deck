extends Card

func _init():
	name = "Morning Star"
	category = "Weapon"
	type = "OneHandedMace"
	slot = [CardType.Enum.MAIN_HAND]
	rarity = 0
	magic_multi = 1
	rare_multi = 1.4
	unique_multi = 1.4
	is_dual_handed = false
	image = "mace"

	var physical_damage = NewCardAttibute.new()
	physical_damage.kind = "Base"
	physical_damage.name = "Physical Damage"
	physical_damage.type = "physical"
	physical_damage.function = "damage"
	physical_damage.description = "Adds physical damage to attacks"
	physical_damage.method = "Added"
	physical_damage.icon = "icon1"
	physical_damage.min = 5
	physical_damage.max = 10

	attributes.append(physical_damage)
