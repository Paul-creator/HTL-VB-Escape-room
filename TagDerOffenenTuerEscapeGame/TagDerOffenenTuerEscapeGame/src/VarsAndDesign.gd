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
		if get_tree().get_root().get_children()[0].get_node_or_null("CanvasLayer/BackgoundUnfocus") != null:
			get_tree().get_root().get_children()[0].get_node("CanvasLayer/BackgoundUnfocus").color = Color(0,0,0,0.48)
		var loadedMap = map.instance()
#		loadedMap.position = get_viewport().get_visible_rect().size / Vector2(2,2)
		loadedMap.rect_scale = Vector2(0.85, 0.85)
		get_tree().get_root().get_children()[0].get_node("CanvasLayer").add_child(loadedMap)
