class_name SquireHandUI extends Node

@onready var card_scene = preload("res://scenes/card.tscn")

@onready var hand = $Hand

var squire: Squire
var generator: GenerateCard = GenerateCard.new()

func discard_hand():
	squire.discard_hand()
	for child in get_children():
		hand.remove_child(child)
		
func draw_card():
	var card := card_scene.instantiate()
	hand.add_card(card)
	
	var generated = generator.generate_card()
	card.copy_from(generated)
	
	squire.add_to_hand(card)
	
func bind_squire(_squire: Squire):
	squire = _squire
