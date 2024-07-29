class_name Card

extends Node

enum CardType {HEAD, GLOVES}

@export var type: CardType
@export var modifiers: Array[Modifier] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func createCard(card_type: CardType) -> void:
	type = card_type
	# Add logic to initialize the card with the given type
