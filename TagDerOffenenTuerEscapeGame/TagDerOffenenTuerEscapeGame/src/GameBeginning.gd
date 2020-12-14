extends Node2D

var _globals
var startedVideo := false

func _ready() -> void:
	_globals = get_tree().get_root().get_node("Globals")
	_globals.showVideo("trailer.webm", 0, 0, 1024, 551, "false", "true", "StartVideoIntro")
	startedVideo = true

func _process(delta: float) -> void:
	if startedVideo and !_globals.idExists("StartVideoIntro"):
		startedVideo = false
		get_tree().change_scene("res://scenes/rooms/Theory/Room_TH_CAD.tscn")

func _on_SkipButton_released() -> void:
	_globals.removeElement("StartVideoIntro")
	get_tree().change_scene("res://scenes/rooms/Theory/Room_TH_CAD.tscn")
