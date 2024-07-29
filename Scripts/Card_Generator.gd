extends Node

func _ready():
	var file = FileAccess.open("res://Resource/Cards.json", FileAccess.READ)
	var content = file.get_as_text()
	prints(content)
	return content
