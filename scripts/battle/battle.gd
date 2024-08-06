class_name Battle extends Node2D

@onready var hero_scene = preload("res://scripts/character/hero/hero.tscn")
@onready var enemy_scene = preload("res://scripts/character/enemy/enemy.tscn")
@onready var card_scene = preload("res://scripts/card/card.tscn")

@onready var battle_ui = $BattleUI
@onready var hero_ui = $HeroControl/CharacterUI
@onready var enemy_ui = $EnemyControl/CharacterUI
@onready var hand_ui = $BattleUI/Hand

@onready var draw_button = $BattleUI/HBoxContainer/DrawButton
@onready var end_turn_button = $BattleUI/HBoxContainer/EndTurnButton

var generator: GenerateCard = GenerateCard.new()
var squire = Squire.new()
var hero : Hero
var enemy : Enemy

func _ready():
	conect_events()
	
	self.hero = hero_scene.instantiate()
	hero.set_fields("Hero", 100)
	hero.attach_inventory()
	battle_ui.add_child(hero)
	hero_ui.bind_character(hero)
	
	self.enemy = enemy_scene.instantiate()
	enemy.set_fields("Enemy", 100)
	#enemy.attach_inventory()
	battle_ui.add_child(enemy)
	enemy_ui.bind_character(enemy)
	
func _process(delta):
	draw_button.disabled = squire.cards_in_hand.size() == squire.max_hand_size
	pass

func _on_end_turn_button_pressed():
	squire.discard_hand()
	for child in hand_ui.get_children():
		hand_ui.remove_child(child)

	hero.take_damage(enemy.get_attribute("attack"))
	hero_ui.update()
	
	enemy.take_damage(hero.get_attribute("attack"))
	enemy_ui.update()

func _on_draw_button_pressed():
	var card := card_scene.instantiate()
	hand_ui.add_card(card)

	var generated = generator.generate_card()
	card.copy_from(generated)
	
	squire.add_to_hand(card)

func _on_child_signal(value):
	print("Signal Received: " + str(value))
	hero.equip(value)
	
func conect_events():
	draw_button.connect("pressed", self._on_draw_button_pressed)
	end_turn_button.connect("pressed", self._on_end_turn_button_pressed)
	Events.connect("card_droped", self._on_child_signal)
