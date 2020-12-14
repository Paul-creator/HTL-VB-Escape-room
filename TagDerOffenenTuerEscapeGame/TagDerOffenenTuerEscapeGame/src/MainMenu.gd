extends Node2D

var _globals

func _ready() -> void:
	_globals = get_tree().get_root().get_node("Globals")
	print(_globals.code)
	print(_globals.codeLAB)
	$MenuOptionsMenu/Quality.add_item(" gering", 0)
	$MenuOptionsMenu/Quality.add_item(" mittel", 1)
	$MenuOptionsMenu/Quality.add_item(" hoch", 2)
	$MenuOptionsMenu/Quality.selected = 0

func starGameLoadScene() -> void:
	get_tree().change_scene("res://GameBeginning.tscn")

func _on_startGame_released() -> void:
	$AnimationPlayer.play("startGameAnim")

func _on_options_released() -> void:
	$AnimationPlayer.play("GetToOptionsMenu")
