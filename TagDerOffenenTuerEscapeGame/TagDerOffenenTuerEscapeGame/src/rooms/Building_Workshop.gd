extends Node2D

var _globals
var isInClassSubMenu := false
var playingAnyAudio := false
var codeSequence := []
var workplacePos := ["AngleGrinder", "Welding", "Smithing"]
var rnd = RandomNumberGenerator.new()

func _ready() -> void:
	rnd.randomize()
	_globals = get_tree().get_root().get_node("Globals")
	var strm
	strm = $SmithingSound.stream as AudioStreamOGGVorbis
	strm.set_loop(false)
	strm = $WeldingSound.stream as AudioStreamOGGVorbis
	strm.set_loop(false)
	strm = $AngleGrinderSound.stream as AudioStreamOGGVorbis
	strm.set_loop(false)
	var available = [1,2,3]
	while available.size() > 0:
		var posToAppend = rnd.randi_range(0,available.size() - 1)
		codeSequence.append(available[posToAppend])
		available.remove(posToAppend)

func _on_ShowAllParts_released() -> void:
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("ShowParts")

func ShowedPartes() -> void:
	$WorkshopOverview/ShowAllParts.hide()
	$BackButton.show()

func HidParts() -> void:
	$WorkshopOverview/ShowAllParts.show()
	$BackButton.hide()

func _on_BackButton_released() -> void:
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("HideParts")

func _on_Class1_released() -> void: 
	_globals.showWebPage("Nussknacker", "https://learningapps.org/watch?v=p2dxknd0320")

func _on_Class4_released() -> void:
	isInClassSubMenu = true
	$BackLayer/VideoRectBackground.show()
	_globals.showVideo("cad_cam.webm", 0, 0, 1024, 551, "true", "true", "CAD_CAM_Video", "webm")
	$BackLayer/SkipButton.show()
	$WorkshopParts.hide()

func _on_SkipButton_released() -> void:
	_globals.removeElement("CAD_CAM_Video")
	$BackLayer/SkipButton.hide()
	$BackLayer/VideoRectBackground.hide()
	isInClassSubMenu = false
	$WorkshopParts.show()

func _on_PlayAudio1_released() -> void:
	HandleMusicPlaying(0)

func _on_PlayAudio2_released() -> void:
	HandleMusicPlaying(1)

func _on_PlayAudio3_released() -> void:
	HandleMusicPlaying(2)

func HandleMusicPlaying(index:int) -> void:
	var player = get_node(str(workplacePos[codeSequence[index] - 1], "Sound"))
	if !playingAnyAudio:
		playingAnyAudio = true
		player.play(0)
	elif player.playing:
		player.stop()
		playingAnyAudio = false

func AudioFinished() -> void:
	playingAnyAudio = false

func _on_BackButtonFromFifthC_released() -> void:
	if $SmithingSound.playing: $SmithingSound.stop()
	if $WeldingSound.playing: $WeldingSound.stop()
	if $AngleGrinderSound.playing: $AngleGrinderSound.stop()
	playingAnyAudio = false
	$BackLayer/Firebasket.hide()
	$BackButton.show()
	$WorkshopParts.show()

func FifthClassCodeChanged(_new_text: String) -> void:
	var ccontainer = $BackLayer/Firebasket/Feuerkorbraetsel_low
	var code = str(ccontainer.get_node("Audio1").text, ccontainer.get_node("Audio2").text, ccontainer.get_node("Audio3").text)
	var expectedCode = str(codeSequence[0], codeSequence[1], codeSequence[2])
	if code == expectedCode:
		$BackLayer/Firebasket/Label.text = str(_globals.CODE_CL5)
		$AnimationPlayer.play("FifthClassNumber")
		$BackLayer/Firebasket/Feuerkorbraetsel_low/OpenAngleGrinder.hide()
		$BackLayer/Firebasket/Feuerkorbraetsel_low/OpenFireBasket.hide()
		$BackLayer/Firebasket/Feuerkorbraetsel_low/OpenSmithing.hide()
		$BackLayer/Firebasket/Feuerkorbraetsel_low/PlayAudio1.hide()
		$BackLayer/Firebasket/Feuerkorbraetsel_low/PlayAudio2.hide()
		$BackLayer/Firebasket/Feuerkorbraetsel_low/PlayAudio3.hide()

func _on_Class2_released() -> void:
	if !$AnimationPlayer.is_playing():
		$BackButton.hide()
		$BackLayer/Firebasket.show()
	$WorkshopParts.hide()

func _on_Class3_released() -> void:
	OS.shell_open("https://www.jigsawexplorer.com/online-jigsaw-puzzle-player.html?url=aHR0cHM6Ly9pLmltZ3VyLmNvbS9hSXZOVzZWLnBuZ18obm9fcHJldmlld180KV8~")

func _on_BackButtonFromSpbob_released() -> void:
	$BackLayer/Automation.hide()
	$BackButton.show()
	$WorkshopParts.show()

func _on_Class5_released() -> void:
	$BackLayer/Automation.show()
	$BackButton.hide()
	$WorkshopParts.hide()

func _on_CodeEnter_released() -> void:
	$WorkshopOverview/CodeEnter.hide()
	$WorkshopOverview/ShowAllParts.hide()
	$BackLayer/Pad.show()
	$BackLayer/PadBackground2.show()
