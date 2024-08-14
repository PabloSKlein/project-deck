extends Resource
class_name NewAffix

@export var kind: String
@export var name: String
@export var type: String
@export var function: String
@export var description: String
@export var names: Array = []  # Array of any type
@export var capacity: String
@export var increased: String
@export var icon: String

# Define a class for the tiers
class Tier:
	var min: int
	var max: int

@export var tiers: Dictionary = {}  # Dictionary of any type
