class_name Enemy 
extends Character

enum EnemyType { NORMAL, ELITE, BOSS }

var enemy_type: EnemyType

func _init(_type: EnemyType = EnemyType.BOSS):
	enemy_type = _type
	
func _ready():
	character_name = "Enemy"
	match enemy_type:
		EnemyType.NORMAL:
			max_health = 100
		EnemyType.ELITE:
			max_health = 200
		EnemyType.BOSS:
			max_health = 500
	health = max_health
	
	var mod := Modifier.new("attack", 20, "")
	self.add_attribute(mod)
	print("Enemy type: ", enemy_type)
	pass
