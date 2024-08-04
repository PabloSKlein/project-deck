class_name Battle extends Node2D

@onready var card_scene: PackedScene = preload("res://scripts/card/card.tscn")

@onready var hand_stack : Hand = $BattleUI/Hand
@onready var draw_button : Button = $BattleUI/HBoxContainer/DrawButton

@onready var generator: GenerateCard = GenerateCard.new()
@onready var inventory = $BattleUI/Inventory
@onready var squire: Squire = Squire.new([])
@onready var hero: Hero = Hero.new(100, inventory)
@onready var hero_health_bar = $BattleUI/ProgressBar
@onready var enemy = $Enemy

func _ready():
	hero_health_bar.max_value = hero.max_health
	inventory = hero.inventory
	enemy.inventory = inventory
	enemy.max_health = 100
	pass

func _process(delta):
	hero_health_bar.value = hero.health
	enemy.update()
	draw_button.disabled = squire.cards_in_hand.size() == squire.max_hand_size
	pass
	
func _on_draw_button_pressed():
	var card = card_scene.instantiate()
	Events.connect("card_droped", self._on_child_signal)
	
	card._ready()
	var generated = generator.generate_card()
	card.copy_from(generated)
	
	squire.add_to_hand(card)
	hand_stack.add_child(card)
	pass
	
func _on_child_signal(value):
	print("Signal Recieved:" + str(value))
	inventory.equip(value)
	hero.equip(value)
	pass	

func _on_end_turn_button_pressed():
	squire.discard_hand()
	enemy.show_status()
	hero.show_status()
	hero.take_damage(enemy.get_attribute("attack"))
	enemy.take_damage(hero.get_attribute("attack"))
	for child in hand_stack.get_children():
		hand_stack.remove_child(child)
	pass
