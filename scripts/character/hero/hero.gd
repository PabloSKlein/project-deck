class_name Hero extends Character

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _init(_max_health: int, _inventory: Inventory) -> void:
	character_name = "Hero"
	max_health = _max_health
	health = _max_health
	inventory = _inventory

