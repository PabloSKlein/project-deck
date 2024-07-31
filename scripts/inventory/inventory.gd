class_name Inventory
extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # Start with the inventory hidden

# Called when an input event is received.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_inventory"):
		toggle_inventory()

# Toggle the visibility of the inventory
func toggle_inventory() -> void:
	visible = not visible
