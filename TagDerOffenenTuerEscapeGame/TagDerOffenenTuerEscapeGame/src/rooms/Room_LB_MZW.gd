extends Node2D

var canClick := true
var previousSlide := 1
var currentSlide := 1
var totalSlides := 4
var dragging := false
var isInSlideshow := false
var isSliding := false
var xDiff := 0.0
var tutorialShown := false
var _globals
const num1 := ["gabi", "dörfl", "griechenland"]
const num2 := ["johanna", "kellner", "spanien"]
const num3 := ["felix", "fuchs", "belgien"]
const num4 := ["emil", "ortner", "schweden"]
const numSeq := ["4", "3", "1", "2"]
var showingNum := false

func _ready() -> void:
	_globals = get_tree().get_root().get_node("Globals")
	$Slideshow/DragInfo/PreviousText.text = "Anfang erreicht"
	$Slideshow/DragInfo/SlidePreviousArrow.hide()
	$Slideshow/DragInfo/SlidePreviousArrow2.hide()
	$CanvasLayer/Number.text = str(_globals.CODE_MZW)
	Globals.currentRoom = Globals.Rooms.MZW

func _process(_delta: float) -> void:
	var mod = getSlideModulate(300)
	$Slideshow/DragInfo.modulate.a = mod

func _on_LogoPress_released() -> void:
	if !isInSlideshow: 
		$ColorRect.rect_position = $MZW_Background/Logo_MZW/LogoPress.get_global_transform().get_origin()
		$ColorRect.rect_size = ($MZW_Background/Logo_MZW/LogoPress.scale * Vector2(800, 600))*Vector2(0.784,0.784)*Vector2(0.253,0.253)
		$Camera2D.zoom_in(($ColorRect.rect_position + ($ColorRect.rect_size / Vector2(2,2))) - $Camera2D.get_camera_position())

func _input(event: InputEvent) -> void:
	if !showingNum:
		if event is InputEventMouseButton and event.button_index == 1 and event.pressed == false and $Camera2D.current_zoom == Vector2($Camera2D.zoom_factor,$Camera2D.zoom_factor):
			var evLocal = make_input_local(event)
			if !$ColorRect.get_rect().has_point(evLocal.position):
				zoomReset()
		
		if event is InputEventMouseButton:
			if (event.button_index == BUTTON_LEFT and event.pressed and !dragging): dragging = true
			elif(event.button_index == BUTTON_LEFT and not event.pressed and dragging): 
				slideSlides()
		if event is InputEventScreenTouch:
			if event.pressed and !dragging: dragging = true
			elif !event.pressed and dragging: 
				slideSlides()
		if event is InputEventMouseMotion and (abs(event.speed.x) > 120 or isSliding):
			if dragging == true:
				var targetSlide = get_tree().get_root().get_node(str("RoomMZW/Slideshow/MZW_slide", currentSlide))
				if !isSliding: xDiff = get_viewport().get_mouse_position().x - targetSlide.position.x
				isSliding = true
				var newPos = event.position.x - xDiff
				if newPos > 0 and newPos < 1024 and tutorialShown: targetSlide.position.x = newPos

func slideSlides() -> void:
	dragging = false
	isSliding = false
	if tutorialShown:
		var targetSlide = get_tree().get_root().get_node(str("RoomMZW/Slideshow/MZW_slide", currentSlide))
		$Tween.interpolate_property(targetSlide, "position", targetSlide.position, Vector2(512, 300), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		if $Slideshow/DragInfo.modulate.a == 1:
			if 512 > targetSlide.position.x: showNextSlide()
			elif 512 < targetSlide.position.x: showPreviousSlide()
		$Tween.start()

func zoomReset() -> void:
	if canClick: 
		$Camera2D.zoom_out(Vector2(512,300))
		$Camera2D.zoom_factor = 0.25
		$Camera2D.reload()

func _on_SlideshowPress_released() -> void:
	if !isInSlideshow: 
		$AnimationPlayer.play("OpenSlideshow")
		isInSlideshow = true

func zoomToSlideShow() -> void:
	$ColorRect.rect_position = $MZW_Background/SlideshowPress.get_global_transform().get_origin()
	$ColorRect.rect_size = ($MZW_Background/SlideshowPress.scale * Vector2(800, 600))*Vector2(0.784,0.784)
	$Camera2D.zoom_in(($ColorRect.rect_position + ($ColorRect.rect_size / Vector2(2,2))) - $Camera2D.get_camera_position())

func _on_PreviousSlideButton_released() -> void:
	if $Slideshow/PreviousSlide.visible == true:
		$Slideshow/PreviousSlide.hide()

func showPreviousSlide() -> void:
	previousSlide = currentSlide
	currentSlide = currentSlide - 1
	if currentSlide < 1:
		currentSlide = 1
	if currentSlide == 1:
		$Slideshow/DragInfo/PreviousText.text = "Anfang erreicht"
		$Slideshow/DragInfo/SlidePreviousArrow.hide()
		$Slideshow/DragInfo/SlidePreviousArrow2.hide()
	else:
		$Slideshow/DragInfo/PreviousText.text = "Vorherige Folie"
		$Slideshow/DragInfo/SlidePreviousArrow.show()
		$Slideshow/DragInfo/SlidePreviousArrow2.show()
	$Slideshow/DragInfo/NextText.text = "Nächste Folie"
	$Slideshow/DragInfo/SlideNextArrow.show()
	$Slideshow/DragInfo/SlideNextArrow2.show()
	showCurrentSlide()

func showNextSlide() -> void:
	previousSlide = currentSlide
	currentSlide = currentSlide + 1
	if currentSlide > totalSlides: currentSlide = totalSlides
	if currentSlide == totalSlides: 
		$Slideshow/DragInfo/NextText.text = "Ende erreicht"
		$Slideshow/DragInfo/SlideNextArrow.hide()
		$Slideshow/DragInfo/SlideNextArrow2.hide()
	else:
		$Slideshow/DragInfo/SlideNextArrow.show()
		$Slideshow/DragInfo/SlideNextArrow2.show()
		$Slideshow/DragInfo/NextText.text = "Nächste Folie"
	$Slideshow/DragInfo/PreviousText.text = "Vorherige Folie"
	$Slideshow/DragInfo/SlidePreviousArrow.show()
	$Slideshow/DragInfo/SlidePreviousArrow2.show()
	showCurrentSlide()

func _on_NextSlideButton_released() -> void:
	if $Slideshow/NextSlide.visible == true:
		$Slideshow/NextSlide.hide()

func _on_PreviousSlideButton_pressed() -> void:
	if $Slideshow/PreviousSlide.visible == false:
		$Slideshow/PreviousSlide.show()

func _on_NextSlideButton_pressed() -> void:
	if $Slideshow/NextSlide.visible == false:
		$Slideshow/NextSlide.show()

func showCurrentSlide() -> void:
	var prevSlide = get_tree().get_root().get_node(str("RoomMZW/Slideshow/MZW_slide", previousSlide))
	var curSlide = get_tree().get_root().get_node(str("RoomMZW/Slideshow/MZW_slide", currentSlide))
	curSlide.position.x = prevSlide.position.x
	prevSlide.hide()
	curSlide.show()
	$Tween.interpolate_property(curSlide, "position", curSlide.position, Vector2(512, 300), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func instantZoomOut() -> void:
	$Camera2D.zoom = Vector2(1,1)
	$Camera2D.offset = Vector2(512,300)

func getSlideModulate(fullModAtDiff: float) -> float:
	var sPos = 512
	var nowPos = get_tree().get_root().get_node(str("RoomMZW/Slideshow/MZW_slide", currentSlide)).position.x
	var mod = 0.0
	var diff = 0.0
	if sPos > nowPos: diff = sPos - nowPos
	else: diff = nowPos - sPos
	mod = diff / fullModAtDiff
	if mod > 1: mod = 1
	return mod

func _on_SkipTutorial_released() -> void:
	$AnimationPlayer.play("SlideTutorialOut")

func setTutorialShown() -> void:
	tutorialShown = true

func _on_CloseSlides_released() -> void:
	$AnimationPlayer.play("CloseSlideshow")
	isInSlideshow = false

func isDone() -> void:
	if( $Slideshow/MZW_slide1/fill1.text == numSeq[0] and
		$Slideshow/MZW_slide1/fill2.text == numSeq[1] and
		$Slideshow/MZW_slide1/fill3.text == numSeq[2] and
		$Slideshow/MZW_slide1/fill4.text == numSeq[3] 
		):
#		if( $Slideshow/MZW_slide2/_1_fname.text.to_lower() == num1[0] and
#			$Slideshow/MZW_slide2/_1_lname.text.to_lower() == num1[1] and
#			$Slideshow/MZW_slide2/_1_country.text.to_lower() == num1[2] and
#			$Slideshow/MZW_slide2/_2_fname.text.to_lower() == num2[0] and
#			$Slideshow/MZW_slide2/_2_lname.text.to_lower() == num2[1] and
#			$Slideshow/MZW_slide2/_2_country.text.to_lower() == num2[2] and
#			$Slideshow/MZW_slide2/_3_fname.text.to_lower() == num3[0] and
#			$Slideshow/MZW_slide2/_3_lname.text.to_lower() == num3[1] and
#			$Slideshow/MZW_slide2/_3_country.text.to_lower() == num3[2] and
#			$Slideshow/MZW_slide2/_4_fname.text.to_lower() == num4[0] and
#			$Slideshow/MZW_slide2/_4_lname.text.to_lower() == num4[1] and
#			$Slideshow/MZW_slide2/_4_country.text.to_lower() == num4[2]
#			):
			$AnimationPlayer.play("ShowNumber")
			DisableAllButtons()

func DisableAllButtons() -> void:
	$MZW_Background/Logo_MZW/LogoPress.hide()
	$MZW_Background/SlideshowPress.hide()
	$Slideshow/PreviousSlideButton.hide()
	$Slideshow/NextSlideButton.hide()
	$Slideshow/CloseSlides.hide()
	$SlideInfoRect/SkipTutorial.hide()
	showingNum = true

func _on__4_fname_text_changed(_new_text: String) -> void: isDone()
func _on__4_lname_text_changed(_new_text: String) -> void:  isDone()
func _on__4_country_text_changed(_new_text: String) -> void: isDone()
func _on__1_fname_text_changed(_new_text: String) -> void: isDone()
func _on__1_lname_text_changed(_new_text: String) -> void: isDone()
func _on__1_country_text_changed(_new_text: String) -> void: isDone()
func _on__2_fname_text_changed(_new_text: String) -> void: isDone()
func _on_2_lname_text_changed(_new_text: String) -> void: isDone()
func _on_2_country_text_changed(_new_text: String) -> void: isDone()
func _on_3_fname_text_changed(_new_text: String) -> void: isDone()
func _on_3_lname_text_changed(_new_text: String) -> void: isDone()
func _on_3_country_text_changed(_new_text: String) -> void: isDone()
func _on_fill1_text_changed(_new_text: String) -> void: isDone()
func _on_fill2_text_changed(_new_text: String) -> void: isDone()
func _on_fill3_text_changed(_new_text: String) -> void: isDone()
func _on_fill4_text_changed(_new_text: String) -> void: isDone()

func _on_BackButton_released() -> void:
	get_tree().change_scene("res://scenes/rooms/Laboratory/Building_Laboratory.tscn")

func _on_fill1_focus_entered() -> void: Globals.getTextOnTouchScreen($Slideshow/MZW_slide1/fill1)
func _on_fill2_focus_entered() -> void: Globals.getTextOnTouchScreen($Slideshow/MZW_slide1/fill2)
func _on_fill3_focus_entered() -> void: Globals.getTextOnTouchScreen($Slideshow/MZW_slide1/fill3)
func _on_fill4_focus_entered() -> void: Globals.getTextOnTouchScreen($Slideshow/MZW_slide1/fill4)

func _on__4_fname_focus_entered() -> void: Globals.getTextOnTouchScreen($Slideshow/MZW_slide2/_4_fname)
func _on__4_lname_focus_entered() -> void: Globals.getTextOnTouchScreen($Slideshow/MZW_slide2/_4_lname)
func _on__4_country_focus_entered() -> void: Globals.getTextOnTouchScreen($Slideshow/MZW_slide2/_4_country)

func _on__3_fname_focus_entered() -> void: Globals.getTextOnTouchScreen($Slideshow/MZW_slide2/_3_fname)
func _on__3_lname_focus_entered() -> void: Globals.getTextOnTouchScreen($Slideshow/MZW_slide2/_3_lname)
func _on__3_country_focus_entered() -> void: Globals.getTextOnTouchScreen($Slideshow/MZW_slide2/_3_country)

func _on__2_fname_focus_entered() -> void: Globals.getTextOnTouchScreen($Slideshow/MZW_slide2/_2_fname)
func _on__2_lname_focus_entered() -> void: Globals.getTextOnTouchScreen($Slideshow/MZW_slide2/_2_lname)
func _on__2_country_focus_entered() -> void: Globals.getTextOnTouchScreen($Slideshow/MZW_slide2/_2_country)

func _on__1_fname_focus_entered() -> void: Globals.getTextOnTouchScreen($Slideshow/MZW_slide2/_1_fname)
func _on__1_lname_focus_entered() -> void: Globals.getTextOnTouchScreen($Slideshow/MZW_slide2/_1_lname)
func _on__1_country_focus_entered() -> void: Globals.getTextOnTouchScreen($Slideshow/MZW_slide2/_1_country)
