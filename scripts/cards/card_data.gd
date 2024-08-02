extends Node

var card_data = {}
var card_data_file_path = "res://resource/card_base.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	card_data = load_card_file(card_data_file_path)

func load_card_file(filePath):
	if FileAccess.file_exists(filePath):
		var dataCard = FileAccess.open(filePath, FileAccess.READ)
		var parseDataCard = JSON.parse_string(dataCard.get_as_text())
		return parseDataCard
	else:
		print("file dont exist")
