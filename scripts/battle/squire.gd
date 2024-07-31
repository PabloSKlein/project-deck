class_name Squire extends Node

var hero: Hero
var inventory: Array[Card] = []

var cardsInHand: Array[Card] = []

var maxHandSize: int = 5

signal reparent_requested(which_card_ui: Card)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _init(_hero: Hero, _inventory: Array[Card]) -> void:
	hero = _hero
	inventory = _inventory

func addToInventory(_card: Card) -> void:
	inventory.push_back(_card)
	
func addToHand(_card: Card) -> void:
	cardsInHand.push_back(_card)

func discardHand() -> void:
	cardsInHand = []

func draw(howManyCards: int) -> void:
	for i in howManyCards:
		drawFromTop()
	pass
	
func equipFromHand(cardIndex: int, slot: int) -> void:
	hero.equip(cardsInHand[cardIndex], slot)
pass
	
func drawFromTop() -> void:
	randomize()  # Seed the random number generator
	var random_card = getRandomElement(inventory)
	cardsInHand.push_back(random_card)
	pass 

func showHand() -> void:
	for card in cardsInHand:
		print(card.nameItem)
	pass 
	
func getRandomElement(arr):
	if arr.size() == 0:
		return null  # Handle the case where the array is empty
	var random_index = randi() % arr.size()  # Get a random index within the array's size
	return arr[random_index]
