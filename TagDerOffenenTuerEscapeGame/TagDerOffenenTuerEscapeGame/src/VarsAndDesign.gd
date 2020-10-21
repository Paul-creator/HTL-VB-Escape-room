extends Node2D

var map = load("res://scenes/general/MapOpen.tscn")
var centerScreen := Vector2.ZERO
var canBePressed := true

func _ready() -> void:
	centerScreen = get_viewport().get_visible_rect().size

func _on_OpenMapButton_pressed() -> void:
	if canBePressed:
		canBePressed = false
		if get_tree().get_root().get_children()[0].get_node("CanvasLayer/BackgoundUnfocus") != null:
			get_tree().get_root().get_children()[0].get_node("CanvasLayer/BackgoundUnfocus").color = Color(0,0,0,0.48)
		var loadedMap = map.instance()
		loadedMap.position = centerScreen / Vector2(2,2)
		loadedMap.scale = Vector2(0.85, 0.85)
		get_tree().get_root().get_children()[0].get_node("CanvasLayer").add_child(loadedMap)
