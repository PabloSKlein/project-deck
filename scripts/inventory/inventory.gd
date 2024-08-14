class_name Inventory extends Control

var slots : Array[InventorySlot]
	
func equip(card: NewCard):
	var slot = get_children_by_type(slots, card.slot_types)
	if(slot != null):
		slot.add_card(card)
	pass

func show_inventory():
	for slot in slots:
		print(slot.slot_type)
	pass

func get_children_by_name(name) -> Node:
	for child in get_children():
		if child.name == name:
			return child
	return null
	
func get_children_by_type(children: Array[InventorySlot], types: Array[CardType.Enum]) -> InventorySlot:
	#find empty slot
	for type in types:
		for child in children:
			var _slot = child as InventorySlot
			if _slot.slot_type == type && _slot.is_empty:
				return _slot
	#find any slot
	for type in types:
		for child in children:
			var _slot = child as InventorySlot
			if _slot.slot_type == type:
				return _slot
	return null
