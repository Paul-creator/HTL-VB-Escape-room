extends Node2D

var collectedMap = false

onready var varsAndDesign = get_node("CanvasLayer/VarsAndDesign")
onready var map = get_node("Map")

func _on_ClickedLinkToExtern_released() -> void:
	varsAndDesign.showWebPage("3D Modell betrachten", "https://cad.onshape.com/documents/115c334e11e4434e7c78d535/w/61bbf9db6d3ca697989d8cda/e/38cdb5f30221e9f4018e5316")

func _on_MapCollection_released() -> void:
	collectedMap = true
	$RoomLayer/CAD/MapCollection.queue_free()
	$RoomLayer/CAD/EmptyCard.show()

func _on_ExitCADRoom_released() -> void:
	if collectedMap == true:
		$AnimationPlayer.play("LeaveCAD")
		pass
	else:
		# show a message that gives the player a hint to collect something he still has not collected 
		pass

func _on_RoomSelect_AULA_released() -> void:
	get_node("Map").changeRoom(0)

func _on_RoomSelect_CLASS_released() -> void:
	get_node("Map").changeRoom(1)

func _on_RoomSelect_MAP_released() -> void:
	pass

func _on_RoomSelect_MAP_pressed() -> void:
	varsAndDesign._on_OpenMapButton_pressed()
