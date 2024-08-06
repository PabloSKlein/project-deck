class_name Battle extends Node2D

@onready var squire_scene = preload("res://scripts/character/squire/squire.tscn")
@onready var hero_scene = preload("res://scripts/character/hero/hero.tscn")
@onready var enemy_scene = preload("res://scripts/character/enemy/enemy.tscn")
@onready var battleUI = $BattleUI
#@onready var enemy = $Enemy

func _ready():
	var squire = squire_scene.instantiate()
	var hero = hero_scene.instantiate()
	var enemy = enemy_scene.instantiate()

	hero.set_fields("Hero", 100)
	hero.attach_inventory()

	enemy.set_fields("enemy", 100)
	#enemy.attach_inventory()  # If enemy also needs inventory
	
	squire.squire = Squire.new()
	squire.squire.hero = hero
	
	battleUI.add_child(squire)
	battleUI.add_child(hero)
	battleUI.add_child(enemy)

	
