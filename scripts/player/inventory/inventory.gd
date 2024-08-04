class_name Inventory extends Control

@onready var grid_container = $Control

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
	var container = get_children_by_name("Control")
	var slot = get_children_by_type(container.get_children(), card.slot_types)
	if(slot != null):
		slot.add_card(card)
	pass

func get_children_by_name(name) -> Node:
	for child in get_children():
		if child.name == name:
			return child
	return null
	
func get_children_by_type(children: Array[Node], types: Array[CardType.Enum]) -> InventorySlot:
	#find empty slot
	for type in types:
		for child in children:
			var _slot = child as InventorySlot
			if _slot.slot_type == type && _slot.isEmpty:
				return _slot
	#find any slot
	for type in types:
		for child in children:
			var _slot = child as InventorySlot
			if _slot.slot_type == type:
				return _slot
	return null
