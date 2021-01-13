extends Node2D

func _ready() -> void:
	Globals.currentRoom = Globals.Rooms.NAWI
	$CanvasLayer/DialogBox/Content.text = "Klicke auf die Begriffe Instagram oder YouTube für mehr Infos"
	$CanvasLayer/DialogBox.show()

func _on_instagramButton_released() -> void:
	OS.shell_open("https://www.instagram.com/nawi.htlvb/")

func _on_youtubeButton_released() -> void:
	OS.shell_open("https://www.youtube.com/channel/UCLA6kv7sN_6bCBSQbEwTv2Q/")

func _on_DialogOkButton_released() -> void:
	$CanvasLayer/DialogBox.hide()
	$CanvasLayer2/Sprite/instagramButton.show()
	$CanvasLayer2/Sprite/youtubeButton.show()
