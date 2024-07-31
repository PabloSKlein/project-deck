class_name Hand
extends HBoxContainer

func _ready() -> void:
	for child in get_children():
		var card_ui := child as Card
		print('card_ui')
		print(card_ui)
		card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)

func _on_card_ui_reparent_requested(child: Card) -> void:
	child.reparent(self)
