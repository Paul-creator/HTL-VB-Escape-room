extends Node2D

var subj_text_FET = "[center][color=#ff9900]FET\nFertigungstechnik\n\n\n[/color][color=#000000]Welche Werkstoffe werden in F[color=#0000ff]A[/color]hrzeugen verwendet und wie kann man diese Werkstoffe bearbeiten[/color][/center]"
var subj_text_PLP = "[center][color=#ff9900]PLP\nPlanung und Projektierung\n\n\n[/color][color=#000000]En[color=#0000ff]T[/color]wurf einer Heizung-, Kältetechnik-, Lüftung- und Sanitäranlage [/color][/center]"
var subj_text_TMB = "[center][color=#ff9900]TMB\nTechnische Mechanik und Berechnung\n\n\n[/color][color=#000000]St[color=#0000ff]A[/color]tik einer Eisenbahnbrücke berechnen[/color][/center]"
var subj_text_AIIT = "[center][color=#ff9900]AIIT\nAngewandte Informatik und fachspezifische Informationstechnik\n\n\n[/color][color=#000000]Programmieren von [color=#0000ff]M[/color]icrocomputern in Haushaltsgeräten oder Garagentoren[/color][/center]"
var subj_text_SWP = "[center][color=#ff9900]SWP\nSoftwareentwicklung und Projektmanagement\n\n\n[/color][color=#000000]Wie prog[color=#0000ff]R[/color]ammiert man Computerspiel[/color][/center]"
var subj_text_BET = "[center][color=#ff9900]BET\nBetriebstechnik\n\n\n[/color][color=#000000]Wie ist ein [color=#0000ff]U[/color]nternehmen aufgebaut und organisiert[/color][/center]"

func _on_DialogClose_pressed() -> void:
	$CanvasLayer/DialogBox.hide()

func setTextAndShowDialog(subject:String) -> void:
	if IsMapOpen(): return
	if subject == "FET": $CanvasLayer/DialogBox/RichTextLabel.bbcode_text = subj_text_FET
	elif subject == "PLP": $CanvasLayer/DialogBox/RichTextLabel.bbcode_text = subj_text_PLP
	elif subject == "TMB": $CanvasLayer/DialogBox/RichTextLabel.bbcode_text = subj_text_TMB
	elif subject == "AIIT": $CanvasLayer/DialogBox/RichTextLabel.bbcode_text = subj_text_AIIT
	elif subject == "SWP": $CanvasLayer/DialogBox/RichTextLabel.bbcode_text = subj_text_SWP
	elif subject == "BET": $CanvasLayer/DialogBox/RichTextLabel.bbcode_text = subj_text_BET
	$CanvasLayer/DialogBox.show()

func showClassTimeTable(classShort:String) -> void:
	if IsMapOpen(): return
	$SpecialitiesSelection.hide()
	if classShort == "FS": $timetable_1afmbm.show()
	elif classShort == "GT": $timetable_1ahgti.show()
	elif classShort == "MB": $timetable_1ahmbt.show()
	elif classShort == "WM": $timetable_1ahwim.show()
	elif classShort == "WI": $timetable_1ahwii.show()
	elif classShort == "ME": $timetable_1ahme.show()
	$CanvasLayer2/BackButton.show()

func _on_TouchBackButton_released() -> void:
	$CanvasLayer2/BackButton.hide()
	$SpecialitiesSelection.show()
	$timetable_1afmbm.hide()
	$timetable_1ahgti.hide()
	$timetable_1ahmbt.hide()
	$timetable_1ahwim.hide()
	$timetable_1ahwii.hide()
	$timetable_1ahme.hide()

##############
#  SUBJECTS  #
##############

func _on_mbm_subj_pressed() -> void:
	setTextAndShowDialog("FET")

func _on_gti_subj_pressed() -> void:
	setTextAndShowDialog("PLP")

func _on_mbt_subj_pressed() -> void:
	setTextAndShowDialog("TMB")

func _on_me_subj_pressed() -> void:
	setTextAndShowDialog("AIIT")

func _on_wii_subj_pressed() -> void:
	setTextAndShowDialog("SWP")

func _on_wim_subj_pressed() -> void:
	setTextAndShowDialog("BET")

##############
# CATEGORIES #
##############

func _on_FS_category_released() -> void:
	showClassTimeTable("FS")

func _on_GT_category_released() -> void:
	showClassTimeTable("GT")

func _on_MB_category_released() -> void:
	showClassTimeTable("MB")

func _on_WM_category_released() -> void:
	showClassTimeTable("WM")

func _on_WI_category_released() -> void:
	showClassTimeTable("WI")

func _on_ME_category_released() -> void:
	showClassTimeTable("ME")

func IsMapOpen() -> bool:
	return get_node_or_null("CanvasLayer/Map") != null
