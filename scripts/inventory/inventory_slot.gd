class_name InventorySlot extends Control

@export var slot_type: CardType.Enum
@export var is_empty = true

var card: NewCard

func add_card(new_card):
	self.is_empty = false
	card = new_card

