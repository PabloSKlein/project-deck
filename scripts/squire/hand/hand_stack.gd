class_name HandStack extends HBoxContainer

func _ready():
	Events.reparent_requested.connect(_on_card_ui_reparent_requested)
	
func add_card(card: CardUI) -> void:
	add_child(card)

func _on_card_ui_reparent_requested(child: CardUI) -> void:
	child.reparent(self)
