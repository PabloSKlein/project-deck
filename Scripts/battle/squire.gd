class_name Squire extends Node

var hero: Hero
var inventory: Array[Card] = []
var cardsInHand: Array[Card] = []
var handStack: HBoxContainer
var maxHandSize: int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _init(_hero: Hero, _inventory: Array[Card], _handStack: HBoxContainer) -> void:
	hero = _hero
	inventory = _inventory
	handStack = _handStack

func addToInventory(_card: Card) -> void:
	inventory.push_back(_card)
	
func addToHand(_card: Card) -> void:
	cardsInHand.push_back(_card)
	handStack.add_child(_card)

func discardHand() -> void:
	cardsInHand = []
	for child in handStack.get_children():
		handStack.remove_child(child)

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
