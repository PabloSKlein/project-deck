class_name Battle extends Node2D

@onready var card_scene: PackedScene = preload("res://scripts/card/card.tscn")
@onready var squire_scene: PackedScene = preload("res://scripts/character/squire/squire.tscn")
@onready var hero_scene: PackedScene = preload("res://scripts/character/hero/hero.tscn")
@onready var draw_button : Button = $BattleUI/HBoxContainer/DrawButton

@onready var generator: GenerateCard = GenerateCard.new()
#@onready var inventory = $BattleUI/Inventory
@onready var battleUI = $BattleUI
#@onready var hero: Hero = Hero.new(100, inventory)
#@onready var hero_health_bar = $BattleUI/ProgressBar
@onready var enemy = $Enemy

func _ready():
	var squireNew = squire_scene.instantiate()
	var heroNew = hero_scene.instantiate()
	battleUI.add_child(squireNew)
	battleUI.add_child(heroNew)
	#hero_health_bar.max_value = hero.max_health
	#inventory = hero.inventory
	#enemy.inventory = inventory
	enemy.max_health = 100
	pass

func _process(delta):
	#hero_health_bar.value = hero.health
	enemy.update()
	pass
	
#func _on_child_signal(value):
	#print("Signal Recieved:" + str(value))
	#inventory.equip(value)
	#hero.equip(value)
	#pass	
	# TODO: This need to be passed to squire class
