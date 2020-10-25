extends Node2D

var collectedMap = false

onready var varsAndDesign = get_node("CanvasLayer/VarsAndDesign")
onready var map = get_node("Map")

func _on_ClickedLinkToExtern_released() -> void:
	varsAndDesign.showWebPage("HTL Vöcklabruck", "https://www.htlvb.at/")

func _on_MapCollection_released() -> void:
	collectedMap = true
	$RoomLayer/TableRow2/CollectableMap.queue_free()

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
