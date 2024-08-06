class_name InventorySlot extends Control


@export var slot_type: CardType.Enum
@export var isEmpty = true

var card: Card

@onready var color = $ColorRect
@onready var label = $Label

func _ready():
	#label = self.get_child_by_name("Label")
	#color = self.get_child_by_name("ColorRect")
	if label != null:
		label.text = CardType.get_type_description(slot_type)
	
func get_child_by_name(_name: String) -> Node:
	for child in get_children():
		if child.name == _name:
			return child
	return null

func add_card(new_card):
	self.isEmpty = false
	color.visible = true

