class_name Inventory extends Control
##TODO Não misturar classes de modelo com UI
@onready var slots_grid := $Control

var slots : Array[InventorySlot]

func _ready():
	for slot in slots_grid.get_children():
		slots.push_back(slot as InventorySlot)
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_inventory"):
		toggle_inventory()

func toggle_inventory() -> void:
	visible = not visible
	
func equip(card: Card):
	var slot = get_children_by_type(slots_grid.get_children(), card.slot_types)
	if(slot != null):
		slot.add_card(card)
	pass

func show_inventory():
	for slot in slots_grid.get_children():
		print(slot.slot_type)
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
