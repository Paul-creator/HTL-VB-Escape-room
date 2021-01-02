extends Control

export var justForFunctions := false
var wasInstancedRightNow := true
var previousRoom := 0

func setValues() -> void:
	$MapOpen/TextEdit.text = Globals.mapCodeEntered
	previousRoom = Globals.currentRoom
	Globals.currentRoom = Globals.Rooms.B_THEORY

func _input(event):
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == false and !justForFunctions:
		var evLocal = make_input_local(event)
		if !Rect2(Vector2(0,0),$MapOpen.get_rect().size).has_point(evLocal.position):
			if !wasInstancedRightNow:
				if get_tree().get_root().get_children()[2].get_node_or_null("CanvasLayer/BackgroundUnfocus") != null:
					get_tree().get_root().get_children()[2].get_node("CanvasLayer/BackgroundUnfocus").color = Color(0,0,0,0)
				queue_free()
				Globals.mapCodeEntered = $MapOpen/TextEdit.text
				if get_tree().get_root().get_children()[2].get_node_or_null("CanvasLayer/VarsAndDesign") != null:
					get_tree().get_root().get_children()[2].get_node("CanvasLayer/VarsAndDesign").canBePressed = true
				elif get_tree().get_root().get_children()[2].get_node_or_null("CanvasLayer2/VarsAndDesign") != null:
					get_tree().get_root().get_children()[2].get_node("CanvasLayer2/VarsAndDesign").canBePressed = true
				Globals.currentRoom = previousRoom
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
		Globals.openNewRoomWithVideo("ThToLab.webm", "res://scenes/rooms/Laboratory/Building_Laboratory.tscn")

func _on_TextEdit_focus_entered() -> void:
	var enteredText = JavaScript.eval("prompt('%s', '%s');" % ["Text hier eingeben:", $MapOpen/TextEdit.text], true)
	$MapOpen/TextEdit.text = enteredText
	$MapOpen/TextEdit.release_focus()
	Globals.mapCodeEntered = $MapOpen/TextEdit.text
