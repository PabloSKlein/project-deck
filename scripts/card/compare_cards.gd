extends Node2D

@onready var card_scene = preload("res://scenes/card.tscn")

@onready var cards = $CanvasLayer/VBoxContainer/Cards

var equiped_card
var selected_card

func _ready():
	if equiped_card:
		var equiped_card_ui := card_scene.instantiate()
		equiped_card_ui.test = false
		equiped_card_ui.bind_card(equiped_card)
		cards.add_child(equiped_card_ui)
	
	var selected_card_ui := card_scene.instantiate()
	selected_card_ui.test = false
	selected_card_ui.bind_card(selected_card)
	cards.add_child(selected_card_ui)

func bind_cards(_equipped_card: NewCard, _selected_card: NewCard):
	equiped_card = _equipped_card
	selected_card = _selected_card
