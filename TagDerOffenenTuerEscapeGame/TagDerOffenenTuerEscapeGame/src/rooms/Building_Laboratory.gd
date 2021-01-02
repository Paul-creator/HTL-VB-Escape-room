extends Node2D

var preRoomClip = load("res://scenes/general/PreRoomEnterVideo.tscn")

func _ready() -> void:
	Globals.currentRoom = Globals.Rooms.B_LABORATORY

func _on_NumPadUnlock_released() -> void:
	$BackLayer/PadBackground.show()
	$BackLayer/Pad.show()
	$Clickables.hide()

func _on_EG_released() -> void:
	Globals.openNewRoomWithVideo("Computerlabor.webm", "res://scenes/rooms/Laboratory/Room_LB_COM-LAB.tscn")

func _on_Laboratories_released() -> void:
	Globals.openNewRoomWithVideo("Labore.webm", "res://scenes/rooms/Laboratory/Room_LB_LAB.tscn")

func _on_OG_released() -> void:
	Globals.openNewRoomWithVideo("MZW.webm", "res://scenes/rooms/Laboratory/Room_LB_MZW.tscn")
