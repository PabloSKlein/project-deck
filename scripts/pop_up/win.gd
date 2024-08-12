class_name PopUpWin
extends PopUp

@onready var next_phase_button = $CanvasLayer/Next

signal next_phase

func _ready():
	super._ready()
	next_phase_button.connect("pressed", self._on_next_phase_button_pressed)

func _on_next_phase_button_pressed():
	emit_signal("next_phase")
	hide_popup()
