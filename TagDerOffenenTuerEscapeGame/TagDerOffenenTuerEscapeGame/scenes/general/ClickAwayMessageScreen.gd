extends ColorRect

var startTime := 0

func _ready() -> void:
	startTime = OS.get_ticks_msec() / 1000

func _on_TextureButton_pressed() -> void:
	if OS.get_ticks_msec() / 1000 - startTime > 2: $AnimationPlayer2.play("disappear")
