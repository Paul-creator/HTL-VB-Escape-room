extends Node2D

func _ready() -> void:
	get_tree().change_scene("res://scenes/rooms/Theory/Room_TH_CAD.tscn")

func _on_VideoPlayer_finished() -> void:
	get_tree().change_scene("res://scenes/rooms/Theory/Room_TH_CAD.tscn")
