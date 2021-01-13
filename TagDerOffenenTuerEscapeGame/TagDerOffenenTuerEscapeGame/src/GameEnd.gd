extends Node2D

func _ready() -> void:
	ZZInGameUi.showCurrentTimer()

func _on_feedbackButton_released() -> void:
	OS.shell_open("mailto:reia@htlvb.at?subject=Feedback%20zum%20HTL-Adventure-Game")

func _on_DialogOkButton_released() -> void:
	$CanvasLayer/DialogBox.hide()

func _on_rewardButton_released() -> void:
	$CanvasLayer/DialogBox.show()
