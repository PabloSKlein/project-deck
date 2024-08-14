class_name SquireHandUI extends Node

@onready var card_scene = preload("res://scenes/card.tscn")
@onready var compare_scene = preload("res://scenes/compare_cards.tscn")

@onready var hand = $Hand

var squire: Squire
var generator: GenerateCard = GenerateCard.new()
var teste: NewCardGen = NewCardGen.new()
var compare_ui

func _ready():
	Events.connect("compare_card", self._on_compare_card)
	Events.connect("stop_compare_card", self._on_stop_compare_card)

func discard_hand():
	squire.discard_hand()
	for child in hand.get_children():
		hand.remove_child(child)
		
func draw_card():
	var new_card = generator.new_generate_card()
	var card = generator.generate_card()
	var card_ui := card_scene.instantiate()
	card_ui.bind_card(card)
	
	hand.add_card(card_ui)
	squire.add_to_hand(card)
	
func bind_squire(_squire: Squire):
	squire = _squire

func _on_compare_card(card: CardUI):
	print(card.card.name_item)
	_on_stop_compare_card()
	compare_ui = compare_scene.instantiate()
	var equiped_card
	for slot in squire.hero.inventory.slots:
		if(not slot.is_empty and slot.card.type == card.card.type):
			equiped_card = slot.card
	compare_ui.bind_cards(equiped_card , card.card)
	self.add_child(compare_ui)
	
func _on_stop_compare_card():
	if compare_ui != null:
		compare_ui.queue_free()
