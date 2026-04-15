extends Area2D

enum State { IDLE, NOTIFYING, REVEALED, EXTRACTING, DONE }

const COUNTDOWN_TIME := 30.0
const HOLD_TIME := 3.0

var state := State.IDLE
var player_in_area := false
var countdown_remaining := COUNTDOWN_TIME
var hold_progress := 0.0
var has_run := false  # ✅ prevents multiple runs

@onready var usb_label: Label = $UsbLabel
@onready var proximity_label: Label = $ProximityLabel
@onready var usb_ui: CanvasLayer = $UsbUI
@onready var timer_label: Label = $UsbUI/Panel/TimerLabel
@onready var timer_bar: ProgressBar = $UsbUI/Panel/TimerBar
@onready var hold_label: Label = $UsbUI/Panel/HoldLabel
@onready var hold_bar: ProgressBar = $UsbUI/Panel/HoldBar
@onready var result_label: Label = $UsbUI/Panel/ResultLabel
@onready var win_notification: CanvasLayer = $WinNotification
@onready var notif_timer_label: Label = $WinNotification/ToastPanel/NotifTimerLabel

func _ready() -> void:
	usb_label.visible = false
	proximity_label.visible = false
	usb_ui.visible = false
	win_notification.visible = false
	timer_bar.max_value = COUNTDOWN_TIME
	timer_bar.value = COUNTDOWN_TIME
	hold_bar.max_value = HOLD_TIME
	hold_bar.value = 0.0
	set_process(false)

# ✅ CALL THIS ONCE TO START
func activate() -> void:
	if has_run:
		return
	has_run = true

	# Skip NOTIFYING, go straight to revealed
	state = State.REVEALED
	countdown_remaining = COUNTDOWN_TIME
	hold_progress = 0.0

	# Show the USB immediately
	usb_label.visible = true
	proximity_label.visible = true
	proximity_label.text = "Malicious USB detected!"
	usb_ui.visible = true
	timer_bar.value = countdown_remaining
	hold_bar.value = 0.0
	Global.puzzle_active = true
	set_process(true)

	# Optional: start extraction immediately if HOLD_TIME = 0
	if HOLD_TIME <= 0.0:
		_start_extraction()

func _process(delta: float) -> void:
	match state:
		State.NOTIFYING:
			_handle_notifying(delta)
		State.REVEALED:
			_handle_revealed(delta)
		State.EXTRACTING:
			_handle_extracting(delta)

func _tick_countdown(delta: float) -> bool:
	countdown_remaining -= delta
	return countdown_remaining <= 0.0

func _handle_notifying(delta: float) -> void:
	if _tick_countdown(delta):
		_on_timeout()
		return
	notif_timer_label.text = "Time remaining: %d" % int(ceil(countdown_remaining))

func _handle_revealed(delta: float) -> void:
	if _tick_countdown(delta):
		_on_timeout()
		return
	if player_in_area:
		proximity_label.text = "Malicious USB! Hold E (%ds)" % int(ceil(countdown_remaining))
	if player_in_area and Input.is_action_just_pressed("interact"):
		_start_extraction()

func _start_extraction() -> void:
	state = State.EXTRACTING
	proximity_label.visible = false
	usb_ui.visible = true
	timer_bar.value = countdown_remaining
	hold_bar.value = 0.0
	result_label.visible = false
	hold_label.visible = true
	hold_bar.visible = true
	timer_label.text = "Time remaining: %d" % int(ceil(countdown_remaining))
	hold_label.text = "Hold E to extract USB"

func _handle_extracting(delta: float) -> void:
	if _tick_countdown(delta):
		_on_timeout()
		return
	timer_bar.value = countdown_remaining
	timer_label.text = "Time remaining: %d" % int(ceil(countdown_remaining))

	if player_in_area and Input.is_action_pressed("interact"):
		hold_progress = min(hold_progress + delta, HOLD_TIME)
		hold_bar.value = hold_progress
		if hold_progress >= HOLD_TIME:
			_on_success()
	else:
		hold_progress = 0.0
		hold_bar.value = 0.0

func _on_dismiss_pressed() -> void:
	win_notification.visible = false
	usb_label.visible = true
	state = State.REVEALED
	if player_in_area:
		proximity_label.text = "Malicious USB! Hold E (%ds)" % int(ceil(countdown_remaining))
		proximity_label.visible = true

func _show_result(message: String) -> void:
	win_notification.visible = false
	proximity_label.visible = false
	timer_label.visible = false
	timer_bar.visible = false
	hold_label.visible = false
	hold_bar.visible = false
	usb_ui.visible = true
	result_label.text = message
	result_label.visible = true

func _on_success() -> void:
	if state == State.DONE:
		return
	state = State.DONE
	Global.score += 100
	_show_result("USB extracted! +$100")
	await get_tree().create_timer(2.0).timeout
	_finish()

func _on_timeout() -> void:
	if state == State.DONE:
		return
	state = State.DONE
	Global.score -= 100
	_show_result("The USB uploaded malware! -$100")
	await get_tree().create_timer(2.0).timeout
	_finish()

func _finish() -> void:
	usb_ui.visible = false
	usb_label.visible = false
	proximity_label.visible = false

	timer_label.visible = true
	timer_bar.visible = true
	hold_label.visible = true
	hold_bar.visible = true
	result_label.visible = false

	Global.puzzle_active = false
	state = State.IDLE
	run_timeline()
	set_process(false)
	
	
func _on_body_entered(_body) -> void:
	player_in_area = true
	if state == State.REVEALED:
		proximity_label.text = "Malicious USB! Hold E (%ds)" % int(ceil(countdown_remaining))
		proximity_label.visible = true
		
func run_timeline():
	Dialogic.VAR.chatstep += 1
	Global.counter += 1

	print("chatstep:", Global.chatstep)

	Dialogic.end_timeline()
	await get_tree().process_frame

	Dialogic.start("res://Godot_Game_Files/timeline.dtl")

	print("started timeline")
	
func _on_body_exited(_body) -> void:
	player_in_area = false
	proximity_label.visible = false
	hold_progress = 0.0
	hold_bar.value = 0.0
