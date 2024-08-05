class_name Battle extends Node2D

@onready var squire_scene: PackedScene = preload("res://scripts/character/squire/squire.tscn")
@onready var hero_scene: PackedScene = preload("res://scripts/character/hero/hero.tscn")
@onready var draw_button : Button = $BattleUI/HBoxContainer/DrawButton
@onready var generator: GenerateCard = GenerateCard.new()
@onready var battleUI = $BattleUI
@onready var enemy = $Enemy

func _ready():
	var squireNew = squire_scene.instantiate()
	var heroNew = hero_scene.instantiate()
	battleUI.add_child(squireNew)
	battleUI.add_child(heroNew)
	enemy.max_health = 100
	pass

	
