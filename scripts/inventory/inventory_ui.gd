class_name InventoryUI extends Control

var character: Character

@onready var slots_grid = $Control
@onready var status_ui = $StatusUI

func _ready():
	hide()
	for slot in slots_grid.get_children():
		slot.connect("card_equiped", _on_card_equiped)
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_inventory"):
		toggle_inventory()

func toggle_inventory() -> void:
	visible = not visible

func attach_inventory(_character):
	character = _character
	status_ui.bind_character(character)
	for slot in slots_grid.get_children():
		character.inventory.slots.push_back(slot as InventorySlot)

func _on_card_equiped():
	character.update_attributes()
	status_ui.update_ui()
	pass
