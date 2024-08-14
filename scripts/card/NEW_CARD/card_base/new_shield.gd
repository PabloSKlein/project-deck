extends NewCard

func _init():
	name = "Renegade Shield"
	category = "Shield"
	type = "Shield"
	slot = ["OffHand"]
	rarity = ""
	magic_multi = 1
	rare_multi = 1.4
	unique_multi = 1.4
	is_dual_handed = false
	image = "shield"

	var physical_block = NewCardAttibute.new()
	physical_block.kind = "Base"
	physical_block.name = "Physical Block"
	physical_block.type = "physical"
	physical_block.function = "defense"
	physical_block.description = "Increases physical block chance"
	physical_block.method = "Increased"
	physical_block.icon = "icon1"
	physical_block.min = 5
	physical_block.max = 10

	attributes.append(physical_block)
