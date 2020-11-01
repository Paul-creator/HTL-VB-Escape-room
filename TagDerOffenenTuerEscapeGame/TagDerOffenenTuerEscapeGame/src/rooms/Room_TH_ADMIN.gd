extends Node2D

var justPressed := false
var isNote := false
var anythingOpen := false

func _on_ZoomAdminNote_released() -> void:
	justPressed = true
	isNote = true
	anythingOpen = true
	$CanvasLayer/BackgroundUnfocus.color = Color(0,0,0,0.48)
	$CanvasLayer/Admin_note.show()
	$CanvasLayer/Admin_note.show()
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis1.hide()
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis1.hide()
	$CanvasLayer5/AdminNote/ZoomAdminNote.hide()
	$CanvasLayer5/GetToAdminBot.hide()
	$CanvasLayer2/VarsAndDesign.ChangeMapVisibility(false)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == false and anythingOpen:
		var evLocal = make_input_local(event)
		if isNote:
			$CanvasLayer5/NoteClickAwayDeadzone.rect_position = Vector2((1024-600)/2, (600-380)/2)
			$CanvasLayer5/NoteClickAwayDeadzone.rect_size = $CanvasLayer/Admin_note.get_rect().size - Vector2(50,60)
			if !Rect2($CanvasLayer5/NoteClickAwayDeadzone.rect_position,$CanvasLayer5/NoteClickAwayDeadzone.get_rect().size).has_point(evLocal.position):
				if !justPressed:
					$CanvasLayer/Admin_note.hide()
					$CanvasLayer/BackgroundUnfocus.color = Color(0,0,0,0)
					$CanvasLayer5/AdminNote/Zeugnis/Zeugnis1.show()
					$CanvasLayer5/AdminNote/Zeugnis/Zeugnis1.show()
					$CanvasLayer5/GetToAdminBot.show()
					$CanvasLayer2/VarsAndDesign.ChangeMapVisibility(true)
					$CanvasLayer5/AdminNote/ZoomAdminNote.show()
					anythingOpen = false
				else:
					justPressed = false
		else:
			$CanvasLayer5/NoteClickAwayDeadzone.rect_position = Vector2(260, 0)
			$CanvasLayer5/NoteClickAwayDeadzone.rect_size = Vector2(539,600)
			if !Rect2($CanvasLayer5/NoteClickAwayDeadzone.rect_position,$CanvasLayer5/NoteClickAwayDeadzone.get_rect().size).has_point(evLocal.position):
				if !justPressed:
					$CanvasLayer/Zeugnis.hide()
					$CanvasLayer/BackgroundUnfocus.color = Color(0,0,0,0)
					$CanvasLayer5/GetToAdminBot.show()
					$CanvasLayer5/AdminNote/ZoomAdminNote.show()
					$CanvasLayer2/VarsAndDesign.ChangeMapVisibility(true)
					anythingOpen = false
				else:
					justPressed = false

func _on_GetToAdminBot_released() -> void:
	$CanvasLayer.add_child(load("res://scenes/general/Chatbot.tscn").instance())
	$CanvasLayer2/VarsAndDesign.ChangeMapVisibility(false)
	$CanvasLayer/BackgroundUnfocus.hide()
	$CanvasLayer5/GetToAdminBot.hide()
	$CanvasLayer5/AdminNote/ZoomAdminNote.hide()
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis1.hide()
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis1.hide()

func ResetAfterBotClose() -> void:
	$CanvasLayer2/VarsAndDesign.ChangeMapVisibility(true)
	$CanvasLayer/BackgroundUnfocus.show()
	$CanvasLayer5/GetToAdminBot.show()
	$CanvasLayer5/AdminNote/ZoomAdminNote.show()
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis1.show()
	$CanvasLayer5/AdminNote/Zeugnis/Zeugnis1.show()

func _on_Zeugnis1_released() -> void:
	justPressed = true
	isNote = false
	anythingOpen = true
	$CanvasLayer/BackgroundUnfocus.color = Color(0,0,0,0.48)
	$CanvasLayer/Zeugnis.show()
	$CanvasLayer5/GetToAdminBot.hide()
	$CanvasLayer2/VarsAndDesign.ChangeMapVisibility(false)
	$CanvasLayer5/AdminNote/ZoomAdminNote.hide()
