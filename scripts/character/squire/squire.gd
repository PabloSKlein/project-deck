extends Node
class_name Squire

var blueprints: Array[Card] = []
var cards_in_hand: Array[Card] = []
var max_hand_size: int = 5
@onready var card_scene: PackedScene = preload("res://scripts/card/card.tscn")
@onready var generator: GenerateCard = GenerateCard.new()
@onready var hand_stack: HandSack = $Hand
@onready var draw_button = $HBoxContainer/DrawButton
@onready var end_turn_button = $HBoxContainer/EndTurnButton
#@onready var inventory = $BattleUI/Inventory

signal reparent_requested(which_card_ui: Card)


func _ready():
	draw_button.connect("pressed", self._on_draw_button_pressed)
	end_turn_button.connect("pressed", self._on_end_turn_button_pressed)
	
func _process(delta):
	draw_button.disabled = cards_in_hand.size() == max_hand_size
	pass

#func _init(_blueprints: Array[Card]) -> void:
	#blueprints = _blueprints

func add_to_inventory(_card: Card) -> void:
	blueprints.push_back(_card)

func add_to_hand(_card: Card) -> void:
	cards_in_hand.push_back(_card)
	hand_stack.add_card(_card)

func discard_hand() -> void:
	cards_in_hand = []

func draw(how_many_cards: int) -> void:
	for i in how_many_cards:
		draw_from_top()

func draw_from_top() -> void:
	randomize()  # Seed the random number generator
	var random_card = get_random_element(blueprints)
	cards_in_hand.push_back(random_card)

func show_hand() -> void:
	for card in cards_in_hand:
		print(card.name_item)

func get_random_element(arr):
	if arr.size() == 0:
		return null  # Handle the case where the array is empty
	var random_index = randi() % arr.size()  # Get a random index within the array's size
	return arr[random_index]

func _on_draw_button_pressed():
	var card = card_scene.instantiate()
	Events.connect("card_dropped", self._on_child_signal)
	card._ready()
	var generated = generator.generate_card()
	card.copy_from(generated)
	add_to_hand(card)

func _on_end_turn_button_pressed():
	discard_hand()
	for child in hand_stack.get_children():
		hand_stack.remove_child(child)

func _on_child_signal(value):
	print("Signal Recieved:" + str(value))
	#inventory.equip(value)
	#hero.equip(value)
	pass
