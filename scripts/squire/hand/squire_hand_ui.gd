class_name SquireHandUI extends Node

@onready var card_scene = preload("res://scenes/card.tscn")

@onready var hand = $Hand

var squire: Squire
var generator: GenerateCard = GenerateCard.new()

func discard_hand():
	squire.discard_hand()
	for child in hand.get_children():
		hand.remove_child(child)
		
func draw_card():
	var card = generator.generate_card()
	var card_ui := card_scene.instantiate()
	card_ui.bind_card(card)
	
	hand.add_card(card_ui)
	squire.add_to_hand(card)
	
func bind_squire(_squire: Squire):
	squire = _squire
