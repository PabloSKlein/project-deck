class_name Inventory extends Control

@onready var grid_container = $GridContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	print("log")
	hide() # Start with the inventory hidden

# Called when an input event is received.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_inventory"):
		toggle_inventory()

# Toggle the visibility of the inventory
func toggle_inventory() -> void:
	visible = not visible
	
func equip(card: Card):
	var container = get_children_by_name("GridContainer")
	var slot = get_children_by_type(container.get_children(), card.type)
	if(slot != null):
		slot.add_card(card)
	pass

func get_children_by_name(name) -> Node:
	for child in get_children():
		if child.name == name:
			return child
	return null
	
func get_children_by_type(children: Array[Node], type: Card.CardType) -> InventorySlot:
	for child in children:
		var iSlot = child as InventorySlot
		if iSlot.slot_type == type:
			return iSlot
	return null
