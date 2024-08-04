class_name Enemy extends Node

@onready var healthBar = $ProgressBar
@onready var label = $Label

var health := 100
var max_health := 100
var enemy_name := "Test"

func _ready():
	health = max_health
	healthBar.max_value = max_health
	label.text = enemy_name
	pass

func _process(delta):
	healthBar.value = health
	pass
