# CharacterInventory.gd
class_name CharacterInventory extends Node

@export var inventory_scene = preload("res://scripts/inventory/inventory.tscn")
var inventory: Inventory

func _init():
	inventory = inventory_scene.instantiate()
	add_child(inventory)

func show_inventory():
	inventory.show_inventory()

func equip(card: Card):
	inventory.equip(card)
