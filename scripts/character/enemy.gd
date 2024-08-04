class_name Enemy extends Character

@onready var health_bar = $ProgressBar
@onready var label = $Label

func _ready():
	character_name = "Enemy"
	health = max_health
	health_bar.max_value = max_health
	label.text = character_name
	var mod := Modifier.new("attack", 20)
	self.add_attribute(mod)
	pass

func _process(delta):
	health_bar.value = health
	pass
	
func update():
	health_bar.value = health
	pass
