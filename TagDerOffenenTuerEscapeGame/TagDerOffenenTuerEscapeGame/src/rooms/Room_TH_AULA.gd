extends Node2D

func _on_Monitor_released() -> void:
	$AnimationPlayer.play("GetInScreen")

func showPage() -> void:
	$CanvasLayer2/VarsAndDesign.showWebPage("AULA", "https://learningapps.org/watch?v=p3rfhwhi220")

func zoomToMonitor() -> void:
	var pos = $CanvasLayer2/Monitor.get_global_transform().get_origin()
	var size = $CanvasLayer2/Monitor.get_global_transform().get_scale() * Vector2(800,600)
	$Camera2D.zoom_in((pos + (size / Vector2(2,2))) - $Camera2D.get_camera_position())

func zoomTotallyOut() -> void:
	$Camera2D.zoom_out(Vector2(512,300))
