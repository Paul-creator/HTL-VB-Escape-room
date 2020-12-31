extends Node2D

var rnd = RandomNumberGenerator.new()
var settingsVolume = 100
var settingsMusic = 100
var settingsSFX = 100
var mediaQuality = MediaQuality.low

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

var codeWS
var CODE_CL1
var CODE_CL2
var CODE_CL3
var CODE_CL4
var CODE_CL5

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
	
	codeWS = [7, rnd.randi_range(0,9), 8, 2, rnd.randi_range(0,9)]
	CODE_CL1 = codeWS[0]
	CODE_CL2 = codeWS[1]
	CODE_CL3 = codeWS[2]
	CODE_CL4 = codeWS[3]
	CODE_CL5 = codeWS[4]

func _input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_T) and Input.is_key_pressed(KEY_C): print(str("theory ", code))
	elif Input.is_key_pressed(KEY_L) and Input.is_key_pressed(KEY_C): print(str("laboratory ", codeLAB))
	elif Input.is_key_pressed(KEY_W) and Input.is_key_pressed(KEY_C): print(str("workshop ", codeWS))

func showVideo(url: String, posX: int, posY: int, width: int, height: int, enableControls: String, enableAutoplay: String, id: String, videoFormatType:String):
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
	JavaScript.eval("showVideo('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')" % [url, posX, posY, width, height, windowWidth, windowHeight, enableControls, enableAutoplay, id, videoFormatType], true)

func idExists(id: String) -> bool:
	var jscode = "String(!!document.getElementById('%s'))" % [id]
	return (JavaScript.eval(jscode, true) == "true")

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

func openNewRoomWithVideo(videoURL:String, finishRoomEnterPath:String) -> void:
	var root = get_tree().get_root()
	var tree = get_tree()
	var level
	var globalScenes = ["Globals"]
	
	for c in get_tree().get_root().get_children():
		if !globalScenes.has(c.name):
			level = c
			break
	root.remove_child(level)
	level.call_deferred("free")
	
	var next_level_resource = load("res://scenes/general/PreRoomEnterVideo.tscn")
	var next_level = next_level_resource.instance()
	root.add_child(next_level)
	root.get_node("PreRoomEnterVideo").videoURL = videoURL
	root.get_node("PreRoomEnterVideo").finishRoomEnterPath = finishRoomEnterPath
	root.get_node("PreRoomEnterVideo").start()
	tree.set_current_scene(next_level)

enum MediaQuality {
	low,
	medium,
	high
}
