class_name InventorySlotUI extends InventorySlot

@onready var color = $ColorRect
@onready var label = $Label
@onready var item_image = $EquipedItem 
signal card_equiped()

func _ready():
	if label != null:
		label.text = CardType.get_type_description(slot_type)
	pass

func add_card(new_card):
	var item = load("res://resource/card/item/" + new_card.image + ".png")
	item_image.texture = item
	item_image.scale = Vector2(0.3, 0.3)

	# Center the image within its parent container
	var parent_size = item_image.get_parent().size
	var item_size = item_image.scale * item_image.scale
	item_image.position = (parent_size - item_size) / 2
	
	super.add_card(new_card)
	emit_signal("card_equiped")
