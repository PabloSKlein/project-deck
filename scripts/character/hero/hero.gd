# Hero.gd
class_name Hero extends Character

@onready var progress_bar = $ProgressBar
@onready var label = $Label
var inventory_node: CharacterInventory

func _ready():
	label.text = self.character_name
	progress_bar.max_value = self.max_health
	progress_bar.value = self.health
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
