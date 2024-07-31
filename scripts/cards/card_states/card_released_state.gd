extends CardState

var played: bool

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	card_ui.color.color = Color.DARK_BLUE
	
	played=false
	
	if not card_ui.targets.is_empty():
		played = true

func on_input(_event: InputEvent):
	if played:
		return
	transition_requested.emit(self, CardState.State.BASE)
