extends Node2D

func _on_instagramButton_released() -> void:
	$CanvasLayer2/VarsAndDesign.showWebPage("Instagram", "https://www.instagram.com/nawi.htlvb/")

func _on_youtubeButton_released() -> void:
	$CanvasLayer2/VarsAndDesign.showWebPage("YouTube", "https://www.youtube.com/channel/UCLA6kv7sN_6bCBSQbEwTv2Q/")
