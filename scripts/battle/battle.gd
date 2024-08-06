class_name Battle extends Node2D

@onready var squire_scene = preload("res://scripts/character/squire/squire.tscn")
@onready var hero_scene = preload("res://scripts/character/hero/hero.tscn")
@onready var battleUI = $BattleUI
@onready var enemy = $Enemy

func _ready():
	var squireNew = squire_scene.instantiate()
	var heroNew = hero_scene.instantiate()

	heroNew.set_fields("Hero", 100)
	heroNew.attach_inventory()

	squireNew.squire = Squire.new()
	squireNew.squire.hero = heroNew
	
	battleUI.add_child(squireNew)
	battleUI.add_child(heroNew)

	enemy.set_fields("Enemy", 100)
	#enemy.attach_inventory()  # If enemy also needs inventory
