extends Node2D

@onready var card_scene: PackedScene = preload("res://scripts/card/card.tscn")

@onready var hand_stack : HBoxContainer = $BattleUI/HandHStack
@onready var draw_button : Button = $BattleUI/DrawButton

@onready var generator: GenerateCard = GenerateCard.new()
@onready var squire: Squire = set_up_squire()
@onready var inventory = $BattleUI/Inventory

func _ready():	
	pass

func _process(delta):
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

	print(hand_stack.get_child_count())  # Check number of children before and after adding
	pass
	
func _on_child_signal(value):
	print("Signal Recieved:" + str(value))
	inventory.equip(value)
	#squire.hero.equip(value)
	pass	

func _on_end_turn_button_pressed():
	squire.discard_hand()
	for child in hand_stack.get_children():
		hand_stack.remove_child(child)
	pass

func set_up_squire():
	var hero = Hero.new(10, [
	])
	return Squire.new(hero, [])
