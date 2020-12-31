extends Control

export var justForFunctions := false
var wasInstancedRightNow := true

func _input(event):
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == false and !justForFunctions:
		var evLocal = make_input_local(event)
		if !Rect2(Vector2(0,0),$MapOpen.get_rect().size).has_point(evLocal.position):
			if !wasInstancedRightNow:
				if get_tree().get_root().get_children()[1].get_node_or_null("CanvasLayer/BackgroundUnfocus") != null:
					get_tree().get_root().get_children()[1].get_node("CanvasLayer/BackgroundUnfocus").color = Color(0,0,0,0)
				queue_free()
				if get_tree().get_root().get_children()[1].get_node_or_null("CanvasLayer/VarsAndDesign") != null:
					get_tree().get_root().get_children()[1].get_node("CanvasLayer/VarsAndDesign").canBePressed = true
				elif get_tree().get_root().get_children()[1].get_node_or_null("CanvasLayer2/VarsAndDesign") != null:
					get_tree().get_root().get_children()[1].get_node("CanvasLayer2/VarsAndDesign").canBePressed = true
			else: wasInstancedRightNow = false
		else:
			if wasInstancedRightNow: wasInstancedRightNow = false

func _on_RoomSelect_TH_AULA_released() -> void:
	Globals.openNewRoomWithVideo("Aula.webm", "res://scenes/rooms/Theory/Room_TH_AULA.tscn")

func _on_RoomSelect_TH_CLASS_released() -> void:
	Globals.openNewRoomWithVideo("Klasse.webm", "res://scenes/rooms/Theory/Room_TH_CLASS.tscn")

func _on_RoomSelect_TH_ADMIN_released() -> void:
	Globals.openNewRoomWithVideo("SEK.webm", "res://scenes/rooms/Theory/Room_TH_ADMIN.tscn")

func _on_RoomSelect_TH_NAWI_released() -> void:
	Globals.openNewRoomWithVideo("NWI.webm", "res://scenes/rooms/Theory/Room_TH_NAWI.tscn")

func _on_RoomSelect_TH_GYM_released() -> void:
	Globals.openNewRoomWithVideo("Turnsaal.webm", "res://scenes/rooms/Theory/Room_TH_GYM.tscn")

func _on_CodeOK_released() -> void:
	var parts = Globals.code
	var code = str(parts[0], parts[1], parts[2], parts[3], parts[4])
	if $MapOpen/TextEdit.text == code:
		get_tree().change_scene("res://scenes/rooms/Laboratory/Building_Laboratory.tscn")
