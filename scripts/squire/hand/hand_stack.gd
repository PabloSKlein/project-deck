class_name HandStack extends HBoxContainer

func _ready():
	for child in get_children():
		var card_ui := child as Card
		card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)

func add_card(card: Card) -> void:
	add_child(card)
	card.reparent_requested.connect(_on_card_ui_reparent_requested)

func _on_card_ui_reparent_requested(child: Card) -> void:
	child.reparent(self)
