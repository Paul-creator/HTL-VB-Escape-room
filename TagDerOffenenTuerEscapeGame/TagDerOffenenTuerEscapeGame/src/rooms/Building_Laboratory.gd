extends Node2D

func _on_NumPadUnlock_released() -> void:
	$BackLayer/PadBackground.show()
	$BackLayer/Pad.show()

func _on_EG_released() -> void:
	get_tree().change_scene("res://scenes/rooms/Laboratory/Room_LB_COM-LAB.tscn")

func _on_Laboratories_released() -> void:
	get_tree().change_scene("res://scenes/rooms/Laboratory/Room_LB_LAB.tscn")
