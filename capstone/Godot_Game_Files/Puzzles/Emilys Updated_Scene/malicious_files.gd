extends Node2D

# -----------------------------------------
# 1. File pools
# -----------------------------------------
var file_pool = [
	"Resume.docx", "trojan.exe", "cat_video.src", "GroceryList.txt",
	"Photo_001.jpg.exe", "Update_Patch.zip", "family_photo.jpg",
	"security_patch.exe", "diagram_flowchart.png", "unlocker_tool.exe",
	"project_files.rar", "funny_clip.scr", "voice_memo.m4a",
	"Meeting_Notes.pdf", "bank_statement.exe", "lecture_recording.mov"
]

var malware_files = [
	"trojan.exe", "cat_video.src", "Photo_001.jpg.exe",
	"security_patch.exe", "unlocker_tool.exe", "funny_clip.scr"
]

var total_malicious_this_round = 0
var displayed_files = []
var correct_flags = 0
var incorrect_flags = 0

# -----------------------------------------
# 2. Node references
# -----------------------------------------
@onready var file_buttons = $FileButtons.get_children()
@onready var popup = $Feedback
@onready var popup_label = $Feedback/Label
@onready var continue_button = $Feedback/Continue

@onready var intro_popup = $Intro
@onready var intro_label = $Intro/Label
@onready var intro_continue = $Intro/Continue

@onready var final_popup = $FinalScore
@onready var final_label = $FinalScore/ScoreLabel
@onready var quit_button = $FinalScore/Quit

# -----------------------------------------
# 3. Scene setup
# -----------------------------------------
func _ready():
	randomize()
	intro_popup.popup_centered()
	intro_label.text = "Welcome to the Malware File Detector!\n\nClick on any file you believe is malicious. If you're right, a flag will appear. If you're wrong, you'll get feedback.\n\nChoose wisely."
	intro_continue.connect("pressed", Callable(self, "_on_intro_continue_pressed"))
	continue_button.connect("pressed", Callable(self, "_on_feedback_continue_pressed"))
	quit_button.connect("pressed", Callable(self, "_on_quit_pressed_"))
	
	for button in file_buttons:
		button.connect("pressed", Callable(self, "_on_file_pressed").bind(button))

	generate_random_file_list()

func _on_intro_continue_pressed():
	intro_popup.hide()

func _on_feedback_continue_pressed():
	popup.hide()
# -----------------------------------------
# 4. Random file list generator
# -----------------------------------------
func generate_random_file_list():
	displayed_files = file_pool.duplicate()
	displayed_files.shuffle()
	displayed_files = displayed_files.slice(0, file_buttons.size())
	
	total_malicious_this_round = 0
	for f in displayed_files:
		if malware_files.has(f):
			total_malicious_this_round += 1
			
	populate_file_buttons()

func populate_file_buttons():
	for i in range(file_buttons.size()):
		var button = file_buttons[i]
		var filename = displayed_files[i]

		button.get_node("FileLabel").text = filename
		button.set_meta("filename", filename)
		button.set_meta("flagged", false)
		button.get_node("FlagIcon").visible = false

# -----------------------------------------
# 5. File click handler
# -----------------------------------------
func _on_file_pressed(button):
	if button.get_meta("flagged"):
		return

	var filename = button.get_meta("filename")
	var is_malware = malware_files.has(filename)

	button.set_meta("flagged", true)

	if is_malware:
		correct_flags += 1
		button.get_node("FlagIcon").visible = true
		popup_label.text = "Correct! '%s' is malware." % filename
	else:
		incorrect_flags += 1
		popup_label.text = "Incorrect. '%s' is safe." % filename
	
	popup.popup_centered()
	
	if correct_flags == total_malicious_this_round:
		popup.hide()
		show_final_score()

func show_final_score():
	final_label.text = (
		"All malicious files found!\n\n"
		+ "Correct Flags: + %d\n" % [correct_flags]
		+ "Incorrect Flags: - %d\n" % [incorrect_flags]
		+ "Final Score: %d\n" % [correct_flags - incorrect_flags]
		)
	final_popup.popup_centered()

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
