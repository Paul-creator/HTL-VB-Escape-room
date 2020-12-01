extends Sprite

var enteredCode := ""
var rightCode := "7428"

func _on_Keypad_0_released() -> void: changeCode("0")

func _on_Keypad_1_released() -> void: changeCode("1")

func _on_Keypad_2_released() -> void: changeCode("2")

func _on_Keypad_3_released() -> void: changeCode("3")

func _on_Keypad_4_released() -> void: changeCode("4")

func _on_Keypad_5_released() -> void: changeCode("5")

func _on_Keypad_6_released() -> void: changeCode("6")

func _on_Keypad_7_released() -> void: changeCode("7")

func _on_Keypad_8_released() -> void: changeCode("8")

func _on_Keypad_9_released() -> void: changeCode("9")

func _on_Keypad_C_released() -> void: 
	enteredCode = ""
	$CodeEntered.text = enteredCode

func _on_Keypad_STBY_released() -> void:
	get_parent().get_parent().get_parent().get_node("AnimationPlayer").play("GoBackCAD")

func changeCode(add:String) -> void:
	if enteredCode.length() >= 10: return
	enteredCode = str(enteredCode, add)
	$CodeEntered.text = enteredCode
	if enteredCode == rightCode:
		get_parent().get_parent().get_parent().get_node("AnimationPlayer").play("LeaveKeypadToExit")
