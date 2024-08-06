class_name Enemy extends Character

func _ready():
	character_name = "Enemy"
	max_health = max_health
	health = max_health
	var mod := Modifier.new("attack", 20)
	self.add_attribute(mod)
	pass
