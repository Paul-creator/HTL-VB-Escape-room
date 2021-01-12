extends Node2D

var binary
var decNum
var rnd = RandomNumberGenerator.new()
var canPress = true

func _ready() -> void:
	AlignElements()
	rnd.randomize()
	decNum = Globals.CODE_COMLAB
	binary = decimToBin(decNum)
	$BinaryCode.text = binary
	Globals.currentRoom = Globals.Rooms.COM_LAB

func decimToBin(var dec):
	var stringBin = "" 
	var tmp 
	var cntr = 3
	while(cntr >= 0):
		tmp = dec >> cntr 
		if(tmp & 1):
			stringBin = stringBin + "1"
		else:
			stringBin = stringBin + "0"
		cntr -= 1
	return stringBin

func _on_OkButton_released() -> void:
	if canPress: 
		if decNum == int($LineEdit.text):
			$CanvasLayer/DialogBox/Content.text = str("Korrekt!\nDu hast die binäre Zahl\nerfolgreich in die\nDezimalzahl ", decNum, "\numgewandelt.")
			canPress = false
			$CanvasLayer/DialogBox.show()
		else:
			$CanvasLayer/DialogBox/Content.text = "Leider falsch!\nSchau dir die binäre Zahl\nnochmal genau an und\nversuche es erneut."
			canPress = false
			$CanvasLayer/DialogBox.show()

func AlignElements() -> void:
	var pos = 1024/2 - (($TextPart1.rect_size.x/2) * $TextPart1.rect_scale.x)
	var pos1 = 1024/2 - (($TextPart2.rect_size.x/2) * $TextPart2.rect_scale.x)
	var pos2 = 1024/2 - (($BinaryCode.rect_size.x/2) * $BinaryCode.rect_scale.x)
	var pos3 = 1024/2 - (800 * $OkButton.scale.x / 2)
	var pos4 = 1024/2 - (($LineEdit.rect_size.x/2) * $LineEdit.rect_scale.x)
	$TextPart1.rect_position.x = pos
	$TextPart2.rect_position.x = pos1
	$BinaryCode.rect_position.x = pos2
	$OkButton.position.x = pos3 + 5
	$LineEdit.rect_position.x = pos4 - 5

func _on_BackButton_released() -> void:
	if canPress: get_tree().change_scene("res://scenes/rooms/Laboratory/Building_Laboratory.tscn")

func _on_DialogOkButton_released() -> void:
	$CanvasLayer/DialogBox.hide()
	canPress = true

func _on_LineEdit_focus_entered() -> void:
	Globals.getTextOnTouchScreen($LineEdit)
