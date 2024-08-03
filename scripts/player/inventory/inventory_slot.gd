class_name InventorySlot extends Control

var card: Card
@export var slot_type: Card.CardType
var color : ColorRect

func _ready():
	var label = self.get_child_by_name("Label")
	color = self.get_child_by_name("ColorRect")
	if label != null:
		label.text = get_type_name(slot_type)
	
func get_child_by_name(_name: String) -> Node:
	for child in get_children():
		if child.name == name:
			return child
	return null
	
func _process(delta):
	pass

func _input_event():
	pass
	
func _init(_slot_type: Card.CardType = Card.CardType.HELMET) -> void:
	slot_type = _slot_type

func add_card(new_card):
	if color != null:
		color.visible = true
	pass
	
func get_type_name(type: Card.CardType) -> String:
	match type:
		Card.CardType.HELMET:
			return "Helmet"
		Card.CardType.BODY:
			return "Body Armor"
		Card.CardType.GLOVES:
			return "Gloves"
		Card.CardType.BOOTS:
			return "Boots"
		Card.CardType.BELT:
			return "Belt"
		Card.CardType.WEAPON:
			return "Weapon"
		Card.CardType.POTION:
			return "Potion"
		_:
			return "Unknown Item"
