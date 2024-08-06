class_name Hero extends Character

var inventory_node: CharacterInventory

func _ready():
	attach_inventory()

func attach_inventory():
	inventory_node = CharacterInventory.new()
	add_child(inventory_node)

func show_inventory():
	if inventory_node != null:
		inventory_node.show_inventory()

func equip(card: Card):
	if inventory_node != null:
		inventory_node.equip(card)
		for attribute in card.modifiers:
			add_attribute(attribute)
