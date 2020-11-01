extends Node2D

export var showMap := true
var map = load("res://scenes/general/MapOpen.tscn")
var canBePressed := true

func _ready() -> void:
	if !showMap:
		$CanvasLayer/HBoxContainer.hide()

func showWebPage(titel: String, url: String):
	var paths = [
		"res://ExternalWebGame/index.js",
	]

	var file = File.new()
	var js = '' 
	for path in paths:
		file.open(path, File.READ)
		js += file.get_as_text() + '\n'
		file.close()
	JavaScript.eval(js, true)
	JavaScript.eval("showWebsite('%s', '%s')" % [titel, url], true)

func _on_OpenMapButton_pressed() -> void:
	if canBePressed:
		canBePressed = false
		if get_tree().get_root().get_children()[0].get_node_or_null("CanvasLayer/BackgroundUnfocus") != null:
			get_tree().get_root().get_children()[0].get_node("CanvasLayer/BackgroundUnfocus").color = Color(0,0,0,0.48)
		var loadedMap = map.instance()
		loadedMap.rect_scale = Vector2(0.65, 0.65)
		loadedMap.anchor_left = 0.5
		loadedMap.anchor_right = 0.5
		loadedMap.anchor_top = 0.5
		loadedMap.anchor_bottom = 0.5
		loadedMap.rect_position = Vector2(-loadedMap.rect_size.x/3,-loadedMap.rect_size.y/3)
		get_tree().get_root().get_children()[0].get_node("CanvasLayer").add_child(loadedMap)

func ChangeMapVisibility(isVisible:bool) -> void:
	if isVisible: $CanvasLayer/HBoxContainer.show()
	else: $CanvasLayer/HBoxContainer.hide()
