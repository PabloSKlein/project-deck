class_name Squire extends Node 

var blueprints: Array[Card] = []
var cards_in_hand: Array[Card] = []
var max_hand_size: int = 5

@onready var generator: GenerateCard = GenerateCard.new()
var hero: Hero

func add_to_inventory(_card: Card) -> void:
	blueprints.push_back(_card)

func add_to_hand(_card: Card) -> void:
	cards_in_hand.push_back(_card)
	

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


