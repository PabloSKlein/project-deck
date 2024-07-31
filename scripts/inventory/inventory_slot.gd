class_name InventorySlot
extends Control


@onready var helmet = $helmet

func _ready():
	helmet.text = 'alo'
	pass

func _input_event():
	pass

static func add_card(new_card):
	print(new_card)
	pass

