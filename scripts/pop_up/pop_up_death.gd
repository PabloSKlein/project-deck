class_name PopUpDeath
extends Node2D


@onready var rerun_button = $RerunButton
@onready var main_menu_button = $MainMenuButton

# Sinais para os botões
signal rerun_pressed
signal main_menu_pressed

func _ready():
	rerun_button.connect("pressed", self._on_rerun_button_pressed)
	main_menu_button.connect("pressed", self._on_main_menu_button_pressed)

func _on_rerun_button_pressed():
	emit_signal("rerun_pressed")

func _on_main_menu_button_pressed():
	emit_signal("main_menu_pressed")
