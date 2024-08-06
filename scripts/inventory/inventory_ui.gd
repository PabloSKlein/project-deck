class_name InventoryUI extends Control

var inventory: Inventory

@onready var slots_grid = $Control

func _ready():
	hide()
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_inventory"):
		toggle_inventory()

func toggle_inventory() -> void:
	visible = not visible

func attach_inventory(inventory):
	inventory = inventory
	for slot in slots_grid.get_children():
		inventory.slots.push_back(slot as InventorySlot)
