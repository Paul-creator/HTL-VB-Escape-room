extends Node2D

var collectedMap = false
var allowedToPress := true

onready var varsAndDesign = get_node("CanvasLayer/VarsAndDesign")
onready var map = get_node("Map")

func _on_ClickedLinkToExtern_released() -> void:
	OS.shell_open("https://cad.onshape.com/documents/115c334e11e4434e7c78d535/w/61bbf9db6d3ca697989d8cda/e/38cdb5f30221e9f4018e5316")
#	varsAndDesign.showWebPageInNewTap("https://cad.onshape.com/documents/115c334e11e4434e7c78d535/w/61bbf9db6d3ca697989d8cda/e/38cdb5f30221e9f4018e5316","Das 3D Modell Wird in einem neuen Tab geöffnet")

func _on_MapCollection_released() -> void:
	if CanPress():
		collectedMap = true
		$CAD/MapCollection.queue_free()
		$CAD/EmptyCard.show()

func _on_ExitCADRoom_released() -> void:
	if CanPress():
		if collectedMap == true:
			$AnimationPlayer.play("LeaveCAD")
		else:
			# show a message that gives the player a hint to collect something he still has not collected 
			pass

func _on_RoomSelect_AULA_released() -> void:
	if $CanvasLayer/BackgroundUnfocus.color != Color(0,0,0,0.48): get_node("Map").changeRoom(0)

func _on_RoomSelect_CLASS_released() -> void:
	if $CanvasLayer/BackgroundUnfocus.color != Color(0,0,0,0.48): get_node("Map").changeRoom(1)

func _on_RoomSelect_MAP_released() -> void:
	pass

func _on_RoomSelect_MAP_pressed() -> void:
	varsAndDesign._on_OpenMapButton_pressed()

func CanPress() -> bool:
	var canPress = true
	
	if Rect2($FlashlightPhoneLayer/Light2D/PhoneImg/PhoneRect.get_global_rect().position,$FlashlightPhoneLayer/Light2D/PhoneImg/PhoneRect.get_rect().size).has_point(get_global_mouse_position()):
		canPress = false
	elif !Rect2($FlashlightPhoneLayer/Light2D/FlashlightRect.get_global_rect().position,$FlashlightPhoneLayer/Light2D/FlashlightRect.get_rect().size).has_point(get_global_mouse_position()):
		canPress = false
	return canPress


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == false and $Camera2D.current_zoom == Vector2($Camera2D.zoom_factor,$Camera2D.zoom_factor):
		var evLocal = make_input_local(event)
		if !Rect2($CanvasLayer/ColorRect.get_global_rect().position,$CanvasLayer/ColorRect.get_rect().size).has_point(evLocal.position):
			$Camera2D.zoom_out(Vector2(512, 300))

func _on_CarTopDown_pressed() -> void:
	$CanvasLayer/BackgroundUnfocus.color = Color(0,0,0,0.48)
	$CanvasLayer/Control/CarTopDownImage.show()

func _on_CarBoard_pressed() -> void:
	$CanvasLayer/BackgroundUnfocus.color = Color(0,0,0,0.48)	
	$CanvasLayer/Control/CarBoardImage.show()

func _on_CarTopDown_released() -> void:
	$CanvasLayer/BackgroundUnfocus.color = Color(0,0,0,0)
	$CanvasLayer/Control/CarTopDownImage.hide()

func _on_CarBoard_released() -> void:
	$CanvasLayer/BackgroundUnfocus.color = Color(0,0,0,0)
	$CanvasLayer/Control/CarBoardImage.hide()

func _on_BackButton_released() -> void:
	$AnimationPlayer.play("GoBackCAD")
