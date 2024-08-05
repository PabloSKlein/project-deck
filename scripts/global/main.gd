class_name Main extends Node

var hero: Hero;
var squire: Squire;
@onready var health_bar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	var inventory := Inventory.new()
	hero = Hero.new(100, inventory)
	#squire = Squire.new([])
	
	health_bar.max_value = hero.max_health
	health_bar.value = hero.health
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_battle_button_pressed():
	var battle : Battle = load("res://scripts/battle/battle.tscn").instantiate()
	battle.hero = hero
	battle.squire = squire
	battle._ready()
	var current_scene = get_tree().current_scene
	
	var root = get_tree().root
	root.add_child(battle)

	get_tree().current_scene = battle

	current_scene.queue_free()
	pass
