extends Control

onready var roomAula = preload("res://scenes/rooms/Theory/Room_TH_AULA.tscn")
onready var roomClass = preload("res://scenes/rooms/Theory/Room_TH_CLASS.tscn")
onready var roomAdmin = preload("res://scenes/rooms/Theory/Room_TH_ADMIN.tscn")
onready var roomNawi = preload("res://scenes/rooms/Theory/Room_TH_NAWI.tscn")
onready var roomGym = preload("res://scenes/rooms/Theory/Room_TH_GYM.tscn")
onready var roomMzw = preload("res://scenes/rooms/Laboratory/Room_LB_MZW.tscn")
onready var roomComLab = preload("res://scenes/rooms/Laboratory/Room_LB_COM-LAB.tscn")
onready var roomLab = preload("res://scenes/rooms/Laboratory/Room_LB_LAB.tscn")
onready var roomWsMe = preload("res://scenes/rooms/Workshop/Room_WS_ME.tscn")
onready var roomWsWi = preload("res://scenes/rooms/Workshop/Room_WS_WI.tscn")
onready var roomWsFs = preload("res://scenes/rooms/Workshop/Room_WS_FS.tscn")
onready var roomWsMb = preload("res://scenes/rooms/Workshop/Room_WS_MB.tscn")
onready var roomWsGt = preload("res://scenes/rooms/Workshop/Room_WS_GT.tscn")
onready var roomWsWm = preload("res://scenes/rooms/Workshop/Room_WS_WM.tscn")

onready var rooms = [roomAula, roomClass, roomAdmin, roomNawi, roomGym, roomMzw, roomComLab, 
					roomLab, roomWsMe, roomWsWi, roomWsFs, roomWsMb, roomWsGt, roomWsWm]

export var justForFunctions := false

var wasInstancedRightNow := true

func changeRoom(roomId:int) -> void:
	get_tree().change_scene_to(rooms[roomId])
	print(str("changed to ", rooms[roomId]))

func _input(event):
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == false and !justForFunctions:
		var evLocal = make_input_local(event)
		if !Rect2(Vector2(0,0),$MapOpen.get_rect().size).has_point(evLocal.position):
			print(wasInstancedRightNow)
			if !wasInstancedRightNow:
				if get_tree().get_root().get_children()[1].get_node_or_null("CanvasLayer/BackgroundUnfocus") != null:
					get_tree().get_root().get_children()[1].get_node("CanvasLayer/BackgroundUnfocus").color = Color(0,0,0,0)
				queue_free()
				if get_tree().get_root().get_children()[1].get_node_or_null("CanvasLayer/VarsAndDesign") != null:
					get_tree().get_root().get_children()[1].get_node("CanvasLayer/VarsAndDesign").canBePressed = true
				elif get_tree().get_root().get_children()[1].get_node_or_null("CanvasLayer2/VarsAndDesign") != null:
					get_tree().get_root().get_children()[1].get_node("CanvasLayer2/VarsAndDesign").canBePressed = true
			else: wasInstancedRightNow = false
		else:
			if wasInstancedRightNow: wasInstancedRightNow = false

func _on_RoomSelect_TH_AULA_released() -> void:
	changeRoom(0)

func _on_RoomSelect_TH_CLASS_released() -> void:
	changeRoom(1)

func _on_RoomSelect_TH_ADMIN_released() -> void:
	changeRoom(2)

func _on_RoomSelect_TH_NAWI_released() -> void:
	changeRoom(3)

func _on_RoomSelect_TH_GYM_released() -> void:
	changeRoom(4)
