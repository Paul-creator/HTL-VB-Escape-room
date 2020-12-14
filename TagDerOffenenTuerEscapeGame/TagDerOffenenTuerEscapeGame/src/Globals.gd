extends Node2D

var rnd = RandomNumberGenerator.new()
var code
var CODE_ADMIN
var CODE_AULA
var CODE_CLASS
var CODE_GYM
var CODE_NAWI

var codeLAB
var CODE_MZW
var CODE_COMLAB
var CODE_LABS
var labDivNums = [16, 18, 24, 36, 48, 72]
var takenLabDivNum

func _ready() -> void:
	rnd.randomize()
	code = [7, rnd.randi_range(0,9), 6, 7, 2]
	CODE_ADMIN = code[4]
	CODE_AULA = code[3]
	CODE_CLASS = code[1]
	CODE_GYM = code[0]
	CODE_NAWI = code[2]
	
	takenLabDivNum = labDivNums[rnd.randi_range(0,labDivNums.size() - 1)]
	codeLAB = [rnd.randi_range(1,9), 144 / takenLabDivNum, rnd.randi_range(1,9)]
	CODE_MZW = codeLAB[0]
	CODE_LABS = codeLAB[1]
	CODE_COMLAB = codeLAB[2]

func showVideo(url: String, posX: int, posY: int, width: int, height: int, enableControls: String, enableAutoplay: String, id: String):
	var paths = [
		"res://ExternalWebGame/index.js",
	]

	var file = File.new()
	var js = '' 
	for path in paths:
		file.open(path, File.READ)
		js += file.get_as_text() + '\n'
		file.close()
	JavaScript.eval(js, true)
	var windowWidth = ProjectSettings.get_setting("display/window/size/width")
	var windowHeight = ProjectSettings.get_setting("display/window/size/height")
	JavaScript.eval("showVideo('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')" % [url, posX, posY, width, height, windowWidth, windowHeight, enableControls, enableAutoplay, id], true)

func idExists(id: String) -> bool:
	var code = "String(document.getElementById('%s').id)" % [id]
	return (JavaScript.eval(code, true) != null)

func removeElement(id: String) -> void:
	JavaScript.eval("document.body.removeChild(document.getElementById('%s'))" % [id], true)

func showWebPage(titel: String, url: String):
	var paths = [
		"res://ExternalWebGame/index.js",
	]

	var file = File.new()
	var js = '' 
	for path in paths:
		file.open(path, File.READ)
		js += file.get_as_text() + '\n'
		file.close()
	JavaScript.eval(js, true)
	JavaScript.eval("showWebsite('%s', '%s')" % [titel, url], true)
