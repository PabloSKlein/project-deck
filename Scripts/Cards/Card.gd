class_name Card

extends Node

enum CardType {HELMET,BODY,GLOVES,BOOTS,BELT,WEAPON,POTION}
enum CardRarity {BASIC, MAGIC, RARE, UNIQUE}

@export var nameItem: String
@export var type: CardType
@export var rarity: CardRarity
@export var prefixes: Array = [] # Added property
@export var suffixes: Array = [] # Added property
@export var modifiers: Array[Modifier] = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func createCard(card_type: CardType, card_rarity: CardRarity) -> void:
	type = card_type
	rarity = card_rarity
	# Add logic to initialize the card with the given type
