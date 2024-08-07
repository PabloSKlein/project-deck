class_name Main extends Node

var battle: Battle

func _on_battle_button_pressed():
	var battle = load("res://scenes/battle.tscn").instantiate()
	var current_scene = get_tree().current_scene
	var root = get_tree().root
	root.add_child(battle)
	get_tree().current_scene = battle
	current_scene.queue_free()
	pass
