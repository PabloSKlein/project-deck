class_name PopUpDeath
extends PopUp

@onready var rerun_button = $CanvasLayer/RerunButton
@onready var main_menu_button = $CanvasLayer/MainMenuButton

signal rerun_pressed
signal main_menu_pressed

func _ready():
	super._ready()
	
	rerun_button.connect("pressed", self._on_rerun_button_pressed)
	main_menu_button.connect("pressed", self._on_main_menu_button_pressed)

func _on_rerun_button_pressed():
	emit_signal("rerun_pressed")
	hide_popup()

func _on_main_menu_button_pressed():
	emit_signal("main_menu_pressed")
	hide_popup()
