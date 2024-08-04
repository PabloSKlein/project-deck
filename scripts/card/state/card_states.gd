class_name CardState
extends Node

enum State {BASE, CLICKED, DRAGGING, RELEASED}
 
signal transition_requested(from: CardState, to: State)

@export var state: State

var card_ui: Card

func enter() -> void:
	pass

func exit() -> void:
	pass

func on_input(_event: InputEvent) -> void:
	pass
	
func on_gui_input(_event: InputEvent) -> void:
	pass
	
func on_mouse_entered() -> void:
	if card_ui:
		card_ui.position.y -= 25  # Move the card 10 pixels up
	pass
	
func on_mouse_exited() -> void:
	if card_ui:
		card_ui.position.y -= -25  # Move the card 10 pixels up
	pass
