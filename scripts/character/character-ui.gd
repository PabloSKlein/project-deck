extends Control

@onready var character_name = $Container/CharacterName
@onready var life_bar = $Container/LifeBar

var character : Character

func bind_character(_character : Character):
	character = _character
	life_bar.max_value = character.max_health
	life_bar.value = character.max_health
	
	character_name.text = character.character_name
	pass
	
func update():
	life_bar.value = character.health
