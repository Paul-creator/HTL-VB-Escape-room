extends Node2D

onready var varsAndDesign = get_node("CanvasLayer/VarsAndDesign")

func _on_ClickedLinkToExtern_released() -> void:
	varsAndDesign.showWebPage("HTL Vöcklabruck", "https://www.htlvb.at/")
