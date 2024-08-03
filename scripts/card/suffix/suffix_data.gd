extends Node

var suffix_data = {}
var suffix_data_file_path = "res://resource/suffix.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	suffix_data = load_suffix_file(suffix_data_file_path)

func load_suffix_file(filePath):
	if FileAccess.file_exists(filePath):
		var dataCard = FileAccess.open(filePath, FileAccess.READ)
		var parseSuffix_data = JSON.parse_string(dataCard.get_as_text())
		return parseSuffix_data
	else:
		print("file dont exist")
