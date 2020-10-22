extends Node2D

func _ready():
	print('ffff')
	var file = File.new()
	file.open("res://ExternalWebGame/javascript.js", File.READ)
	var js = file.get_as_text()
	print('js: \n' + js)
	file.close()
	var js_return = JavaScript.eval(js)
	print(js_return)
	print(js)
