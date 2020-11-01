extends Node2D

func _on_VideoPlayer_finished() -> void:
	get_tree().change_scene("res://scenes/rooms/Theory/Room_TH_CAD.tscn")

func _on_SkipButton_released() -> void:
	get_tree().change_scene("res://scenes/rooms/Theory/Room_TH_CAD.tscn")
