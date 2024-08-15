extends Card

func _init():
	name = "Renegade Shield"
	category = "Shield"
	type = "Shield"
	slot = [CardType.Enum.MAIN_HAND]
	rarity = 0
	magic_multi = 1
	rare_multi = 1.4
	unique_multi = 1.4
	is_dual_handed = false
	image = "shield"

	var physical_block = CardAttibute.new()
	physical_block.kind = "Base"
	physical_block.name = "Physical Block"
	physical_block.type = "physical"
	physical_block.function = "defense"
	physical_block.description = "Increases physical block chance"
	physical_block.method = "Increased"
	physical_block.icon = "axe"
	physical_block.min = 5
	physical_block.max = 10

	attributes.append(physical_block)
