class_name Card

extends Node

enum CardType {HELMET,BODY,GLOVES,BOOTS,BELT,WEAPON,POTION}
enum CardRarity {BASIC, MAGIC, RARE, UNIQUE}

@export var nameItem: String
@export var type: CardType
@export var rarity: CardRarity
@export var prefixes: Array[Prefix] = [] # Added property
@export var suffixes: Array[Suffix] = [] # Added property
@export var modifiers: Array[Modifier] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _init() -> void:
	pass

func get_type_name() -> String:
	match type:
		CardType.HELMET:
			return "Helmet"
		CardType.BODY:
			return "Body Armor"
		CardType.GLOVES:
			return "Gloves"
		CardType.BOOTS:
			return "Boots"
		CardType.BELT:
			return "Belt"
		CardType.WEAPON:
			return "Weapon"
		CardType.POTION:
			return "Potion"
		_:
			return "Unknown Item"
			
func get_rarity_name() -> String:
	match rarity:
		CardRarity.BASIC:
			return "Basic"
		CardRarity.MAGIC:
			return "Magic"
		CardRarity.RARE:
			return "Rare"
		CardRarity.UNIQUE:
			return "Unique"
		_:
			return "Unknown Item"
