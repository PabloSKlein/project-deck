extends Card

func _init():
	name = "Birch Bow"
	category = "Weapon"
	type = "Bow"
	slot = [CardType.Enum.HELMET]
	rarity = 0
	magic_multi = 1
	rare_multi = 1.4
	unique_multi = 1.4
	is_dual_handed = false
	image = "bow"

	var physical_damage = CardAttibute.new()
	physical_damage.kind = "Base"
	physical_damage.name = "Physical Damage"
	physical_damage.type = "physical"
	physical_damage.function = "damage"
	physical_damage.description = "Adds physical damage to attacks"
	physical_damage.method = "Added"
	physical_damage.icon = "axe"
	physical_damage.min = 5
	physical_damage.max = 10

	attributes.append(physical_damage)
