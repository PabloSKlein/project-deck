class_name InventorySlotUI extends InventorySlot

@onready var color = $ColorRect
@onready var label = $Label

signal card_equiped()

func _ready():
	if label != null:
		label.text = CardType.get_type_description(slot_type)
	pass

func add_card(new_card):
	color.visible = true
	super.add_card(new_card)
	emit_signal("card_equiped")
