class_name Battle extends Node2D

@onready var squire_scene = preload("res://scripts/character/squire/squire.tscn")
@onready var hero_scene = preload("res://scripts/character/hero/hero.tscn")
@onready var inventory = preload("res://scripts/inventory/inventory.tscn")
@onready var battleUI = $BattleUI
@onready var enemy = $Enemy

func _ready():
	var inventoryNew = inventory.instantiate()
	inventoryNew._ready()
	var squireNew = squire_scene.instantiate()
	var heroNew = hero_scene.instantiate()
	var teste = inventoryNew.get_child(1).get_children()
	squireNew.squire = Squire.new()
	squireNew.squire.hero = heroNew
	heroNew.inventory = inventoryNew
	
	
	battleUI.add_child(squireNew)
	battleUI.add_child(heroNew)
	enemy.max_health = 100
	pass
