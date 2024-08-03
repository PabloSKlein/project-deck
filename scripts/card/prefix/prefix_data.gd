extends Node

var prefix_data = {}
var prefix_data_file_path = "res://resource/prefix.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	prefix_data = load_prefix_file(prefix_data_file_path)

func load_prefix_file(filePath):
	if FileAccess.file_exists(filePath):
		var dataCard = FileAccess.open(filePath, FileAccess.READ)
		var parsePrefix_data = JSON.parse_string(dataCard.get_as_text())
		return parsePrefix_data
	else:
		print("file dont exist")
