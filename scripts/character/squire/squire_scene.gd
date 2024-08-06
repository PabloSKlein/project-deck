class_name SquireScene
extends Node 
@onready var hand_stack: HandSack = $Hand
@onready var draw_button = $HBoxContainer/DrawButton
@onready var end_turn_button = $HBoxContainer/EndTurnButton
@onready var card_scene = preload("res://scripts/card/card.tscn")
var squire: Squire
var generator: GenerateCard = GenerateCard.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	draw_button.connect("pressed", self._on_draw_button_pressed)
	end_turn_button.connect("pressed", self._on_end_turn_button_pressed)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	draw_button.disabled = squire.cards_in_hand.size() == squire.max_hand_size
	pass

func _on_end_turn_button_pressed():
	squire.discard_hand()
	for child in hand_stack.get_children():
		hand_stack.remove_child(child)
	#hero.take_damage(enemy.get_attribute("attack"))
	#enemy.take_damage(hero.get_attribute("attack"))
		
func _on_draw_button_pressed():
	var card = card_scene.instantiate()
	Events.connect("card_droped", self._on_child_signal)
	card._ready()
	var generated = generator.generate_card()
	card.copy_from(generated)
	squire.add_to_hand(card)
	hand_stack.add_card(card)

func _on_child_signal(value):
	print("Signal Received: " + str(value))
	squire.hero.equip(value)
		
