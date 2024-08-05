class_name InventorySlot extends Control


@export var slot_type: CardType.Enum
@export var isEmpty = true

var card: Card
var color : ColorRect
var label : Label

func _ready():
	label = self.get_child_by_name("Label")
	color = self.get_child_by_name("ColorRect")
	if label != null:
		label.text = CardType.get_type_description(slot_type)
	
func get_child_by_name(_name: String) -> Node:
	for child in get_children():
		if child.name == _name:
			return child
	return null
	
func _process(delta):
	pass

func _input_event():
	pass
	
func _init(_slot_type: CardType.Enum = CardType.Enum.HELMET) -> void:
	slot_type = _slot_type

func add_card(new_card):
	self.isEmpty = false
	if color != null:
		color.visible = true
	pass
