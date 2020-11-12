extends Node2D

var rnd = RandomNumberGenerator.new()
var code
var CODE_ADMIN
var CODE_AULA
var CODE_CLASS
var CODE_GYM
var CODE_NAWI

func _ready() -> void:
	rnd.randomize()
	code = [rnd.randi_range(0,9), rnd.randi_range(0,9), rnd.randi_range(0,9), rnd.randi_range(0,9), rnd.randi_range(0,9)]
	CODE_ADMIN = code[4]
	CODE_AULA = code[3]
	CODE_CLASS = code[1]
	CODE_GYM = code[0]
	CODE_NAWI = code[2]
