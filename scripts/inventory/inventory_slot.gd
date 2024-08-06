class_name InventorySlot extends Control

@export var slot_type: CardType.Enum
@export var isEmpty = true

##TODO separar ui e modelo
@onready var color = $ColorRect
@onready var label = $Label

var card: Card

func _ready():
	if label != null:
		label.text = CardType.get_type_description(slot_type)

func add_card(new_card):
	self.isEmpty = false
	color.visible = true

