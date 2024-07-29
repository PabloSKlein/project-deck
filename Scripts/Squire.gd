class_name Squire

extends Node

var hero: Hero
var inventory: Array[Card] = []
var cards: Array[Card] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func createHero(hero:Hero, inventory: Array[Card]) -> void:
	hero = hero
	inventory = inventory

func discardHand() -> void:
	cards = []

func draw(howManyCards: int) -> void:
	for i in howManyCards:
		drawFromTop()
	pass
	
func drawFromTop() -> void:
	randomize()  # Seed the random number generator
	var random_card = getRandomElement(inventory)
	cards.push_back(random_card)
	pass 
	
func getRandomElement(arr):
	if arr.size() == 0:
		return null  # Handle the case where the array is empty
	var random_index = randi() % arr.size()  # Get a random index within the array's size
	return arr[random_index]
