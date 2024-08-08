class_name HandStack extends HBoxContainer

func add_card(card: CardUI) -> void:
	add_child(card)

func _on_card_ui_reparent_requested(child: Card) -> void:
	child.reparent(self)
