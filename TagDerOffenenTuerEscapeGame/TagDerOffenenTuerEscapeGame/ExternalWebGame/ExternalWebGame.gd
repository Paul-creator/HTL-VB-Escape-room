extends Node2D

func _ready():
	showWebPage('HTL Vöcklabruck', 'https://www.htlvb.at')
	
func showWebPage(titel: String, url: String):
	var path = "res://ExternalWebGame/javascript.tscn"
	var file = File.new()
	print('exists: '+ str(file.file_exists(path)))
	file.open(path, File.READ)
	var js = file.get_as_text()
	file.close()
	JavaScript.eval(js, true)
	JavaScript.eval("showWebsite('%s', '%s')" % [titel, url], true)
	
