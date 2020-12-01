extends Node2D

var isDragging := false
var startPos := 0.0
var startDiff := 0.0

func _ready() -> void:
	startPos = $CanvasLayer2/ScreenContent.position.x

func _on_TouchScreenButton1_released() -> void:
	$CanvasLayer2/Sprite.hide()
	$CanvasLayer2/onScreenLook.show()
	$CanvasLayer2/ScreenDrag.show()
	$CanvasLayer2/ScreenContent.show()
	$CanvasLayer2/PhoneTouches.hide()

func _process(delta: float) -> void:
	if isDragging:
		var posX = get_global_mouse_position().x
		if (posX - startDiff) < startPos:
			$CanvasLayer2/ScreenContent.position.x = posX - startDiff

func _on_ScreenDrag_pressed() -> void:
	startDiff = get_global_mouse_position().x - startPos
	isDragging = true

func _on_ScreenDrag_released() -> void:
	isDragging = false
	if $CanvasLayer2/ScreenContent.position.x - startPos > -360:
		$CanvasLayer2/ScreenContent.position.x = startPos
	else:
		$CanvasLayer2/ScreenContent.hide()
		$CanvasLayer2/ScreenDrag.hide()
		$AudioForVideo.play()
		$CanvasLayer2/VideoOnPhone.show()
		$CanvasLayer2/VideoOnPhone.play()
