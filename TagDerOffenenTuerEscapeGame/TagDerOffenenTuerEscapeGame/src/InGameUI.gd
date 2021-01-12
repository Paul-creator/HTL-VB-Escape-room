extends Node2D

var timeElapsed
var startTime
var hasStarted := false
var penaltySeconds := 0
var doDontHide = ["DialogBox", "FullScreen", "PauseMenu"]
var hiddenTSButtons = []
var pausedTicks := 0
var pauseFrom := 0

func _ready() -> void:
	hideAll()

func _process(delta: float) -> void:
	if hasStarted:
		var timeElapsed = OS.get_ticks_msec() - startTime - pausedTicks
		var totalSeconds = int(timeElapsed / 1000) + penaltySeconds
		var hours = int(totalSeconds / 3600)
		var minutes = (totalSeconds - hours * 3600) / 60
		var seconds = totalSeconds - (hours * 3600 + minutes * 60)
		$CanvasLayer/TimeCounter.text = str("%02d" % hours, ":", "%02d" % minutes, ":", "%02d" % seconds)
#	if OS.window_fullscreen and $CanvasLayer/FullScreen.texture_normal != load("res://graphics/menu/no_fullscreen.png"): $CanvasLayer/FullScreen.texture_normal = load("res://graphics/menu/no_fullscreen.png")
#	elif !OS.window_fullscreen and $CanvasLayer/FullScreen.texture_normal != load("res://graphics/menu/fullscreen.png"): $CanvasLayer/FullScreen.texture_normal = load("res://graphics/menu/fullscreen.png")

func start() -> void:
	showAll()
	startTime = OS.get_ticks_msec()
	hasStarted = true

func pause(hide:bool) -> void:
	if hide: hideAll()
	hasStarted = false
	pauseFrom = OS.get_ticks_msec()

func resume() -> void:
	if !visible: showAll()
	hasStarted = true
	pausedTicks = pausedTicks + (OS.get_ticks_msec() - pauseFrom)

func hideAll() -> void:
	hide()
	for c in $CanvasLayer.get_children():
		if !doDontHide.has(c.name): c.hide()

func showAll() -> void:
	show()
	for c in $CanvasLayer.get_children():
		if !doDontHide.has(c.name): c.show()

func showHint(hint:String, timePenalty:int) -> void:
	$CanvasLayer/DialogBox/Content.text = hint
	$CanvasLayer/DialogBox.show()
	penaltySeconds = penaltySeconds + timePenalty
	hideAllVisibleTSButtons()

func _on_DialogOkButton_released() -> void:
	$CanvasLayer/DialogBox/Content.text = ""
	$CanvasLayer/DialogBox.hide()
	showAllPrevVisibleTSButtons()

func _on_HintButton_pressed() -> void:
	var roomHintCount = Globals.getRoomHintCount(Globals.currentRoom)
	var timePenalty
	if Globals.openVideos.size() > 0:
		for vid in Globals.openVideos:
			Globals.removeElement(vid)
		Globals.openVideos.clear()
	if roomHintCount == 0: 
		timePenalty = 30
		showHint(Globals.hints[Globals.currentRoom][0], timePenalty)
		Globals.addRoomHintCount(Globals.currentRoom, 1)
	else: 
		timePenalty = 60
		if roomHintCount > 1: timePenalty = 0
		showHint(Globals.hints[Globals.currentRoom][Globals.hints[Globals.currentRoom].size() - 1], timePenalty)
		if roomHintCount == 1: Globals.addRoomHintCount(Globals.currentRoom, 1)
	if timePenalty > 0: 
		$CanvasLayer/PenaltyViewer.text = str("+ ", timePenalty)
		$AnimationPlayer.play("showPenalty")

func _on_FullScreen_pressed() -> void:
	OS.window_fullscreen = !OS.window_fullscreen
	if OS.window_fullscreen: $CanvasLayer/FullScreen.texture_normal = load("res://graphics/menu/no_fullscreen.png")
	else: $CanvasLayer/FullScreen.texture_normal = load("res://graphics/menu/fullscreen.png")

func hideAllVisibleTSButtons() -> void:
	var level
	var globalScenes = ["Globals", "ZZInGameUi"]
	
	for c in get_tree().get_root().get_children():
		if !globalScenes.has(c.name):
			level = c
			break
	
	for c in level.get_children():
		if c.get_child_count() > 0:
			get_allChildren(c)
		if c is TouchScreenButton and c.visible: 
			c.hide()
			hiddenTSButtons.append(c)

func get_allChildren(parent) -> void:
	for c in parent.get_children():
		if c.get_child_count() > 0:
			get_allChildren(c)
		if c is TouchScreenButton and c.visible: 
			c.hide()
			hiddenTSButtons.append(c)

func showAllPrevVisibleTSButtons() -> void:
	for c in hiddenTSButtons:
		if c != null:
			c.show()
	hiddenTSButtons.clear()

func _on_PauseOkButton_released() -> void:
	$CanvasLayer/PauseMenu.hide()
	resume()
	showAllPrevVisibleTSButtons()

func _on_PauseButton_pressed() -> void:
	$CanvasLayer/PauseMenu.show()
	pause(false)
	hideAllVisibleTSButtons()
