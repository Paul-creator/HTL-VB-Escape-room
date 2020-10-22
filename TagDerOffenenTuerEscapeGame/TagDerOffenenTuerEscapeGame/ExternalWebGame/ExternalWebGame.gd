extends Node2D

func a():
	var path = "res://ExternalWebGame/javascript.tscn"
	var file = File.new()
	print('exists: '+ str(file.file_exists(path)))
	file.open(path, File.READ)
	var js = file.get_as_text()
	file.close()
	JavaScript.eval(js)
	print(js)
	
func b():
	var js = """
		var list = [1,2,3,4]
		for(i = 0; i< list.length; i++){
			console.log(list[i])
		}
	"""
	var js_return = JavaScript.eval(js)

func _ready():
	a()
	
