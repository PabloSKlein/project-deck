class_name InventorySlotUI extends InventorySlot

@onready var color = $ColorRect
@onready var label = $Label
@onready var item_image = $EquipedItem 
@onready var item_slot = $ItemSlot
signal card_equiped()

func _ready():
	pass

func add_card(new_card):
	set_slot_image(new_card.image)
	set_slot_color(new_card.rarity)
	item_slot.hide()
	super.add_card(new_card)
	emit_signal("card_equiped")

func set_slot_color(rarity):
	match rarity:
		1:
			color.color = Color.BLUE
			color.show()
		2:
			color.color = Color.YELLOW
			color.show()
		3:
			color.color = Color.RED
			color.show()

func set_slot_image(imagem):
	var item = load("res://resource/card/item/" + imagem + ".png")
	item_image.texture = item
	item_image.scale = Vector2(0.25, 0.25)
	var parent_size = item_image.get_parent().size
	var item_size = item_image.scale * item_image.scale
	item_image.position = (parent_size - item_size) / 2
