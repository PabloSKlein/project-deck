class_name CardReleasedState extends CardState

var played: bool
var stored_cards: Dictionary = {}
signal card_stored(card_data)

func enter() -> void:
#	card_ui.color.color = Color.DARK_BLUE
	played = false
	var targets = card_ui.targets
	if not targets.is_empty():
		played = true
		store_card_info(targets)
		remove_card_from_board()
		log_card_stored()

func on_input(_event: InputEvent):
	if played:
		return
	transition_requested.emit(self, CardState.State.BASE)

func store_card_info(target: Array[Node]) -> void:
	if card_ui:
		var card_details = card_ui.card.get_card_details()
		stored_cards[card_ui.card.name] = card_details
		emit_signal("card_stored", stored_cards)
		Events.card_droped.emit(card_ui.card)

func remove_card_from_board() -> void:
	if card_ui:
		card_ui.queue_free()

func log_card_stored() -> void:
	print("Logging stored card data:")
	for card_name in stored_cards.keys():
		print(stored_cards[card_name])
		var card_info = stored_cards[card_name]
