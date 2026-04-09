extends Node2D

#-----------------------------------------
#1. Panel references
#-----------------------------------------
@onready var credential_panel = $Control/CredentialPanel 
@onready var feedback_panel = $Control/FeedbackPanel 
@onready var ranking_panel = $Control/RankingPanel 
@onready var final_popup = $Control/FinalPopup

#-----------------------------------------
#2. Feedback text references
#-----------------------------------------
@onready var feedback_title = $Control/FeedbackPanel/Title 
@onready var feedback_body = $Control/FeedbackPanel/Body

#-----------------------------------------
#3. Ranking panel references
#-----------------------------------------
@onready var password1 = $Control/RankingPanel/PasswordList/password1 
@onready var password2 = $Control/RankingPanel/PasswordList/password2 
@onready var password3 = $Control/RankingPanel/PasswordList/password3 
@onready var password4 = $Control/RankingPanel/PasswordList/password4 
@onready var password5 = $Control/RankingPanel/PasswordList/password5
@onready var confirm_button = $Control/RankingPanel/Confirm 
@onready var help_button = $Control/RankingPanel/Help 
@onready var help_text = $Control/RankingPanel/Help/Text

#-----------------------------------------
#4. Final popup references
#-----------------------------------------
@onready var final_body = $Control/FinalPopup/Body 
@onready var final_continue = $Control/FinalPopup/Continue

#-----------------------------------------
#5. Ranking logic
#-----------------------------------------
var current_rank := 1 
var ranked := {}

#Correct strongest → weakest order
var correct_order = [ 
					"!Frog$Moon&River2026", 
					"n!neLizards", 
					"Summer2024!", 
					"Henry!123", 
					"Password123" ]

#-----------------------------------------
#6. Connect all buttons
#-----------------------------------------
func _ready() -> void:
	initialize()

func initialize():
	credential_panel.visible = true 
	feedback_panel.visible = false 
	ranking_panel.visible = false 
	final_popup.visible = false
	help_text.visible = false
# Credential panel buttons
	$Control/CredentialPanel/Accept.connect("pressed", Callable(self, "_on_Accept_pressed"))
	$Control/CredentialPanel/Reject.connect("pressed", Callable(self, "_on_Reject_pressed"))

# Feedback panel continue
	$Control/FeedbackPanel/Continue.connect("pressed", Callable(self, "_on_Continue_pressed"))

# Ranking panel password buttons
	password1.connect("pressed", Callable(self, "_on_password1_pressed"))
	password2.connect("pressed", Callable(self, "_on_password2_pressed"))
	password3.connect("pressed", Callable(self, "_on_password3_pressed"))
	password4.connect("pressed", Callable(self, "_on_password4_pressed"))
	password5.connect("pressed", Callable(self, "_on_password5_pressed"))

# Ranking panel Confirm + Help
	$Control/RankingPanel/Confirm.connect("pressed", Callable(self, "_on_Confirm_pressed"))

# -----------------------------
# Help text (click to toggle)
# -----------------------------
	help_text.text = """What Makes a Password Strong?
		• Use 12+ characters
		• Mix uppercase, lowercase, numbers, and symbols
		• Avoid personal info (names, birthdays, pets)
		• Avoid common words or patterns
		• Use unpredictable combinations that don’t form real words
		Examples:
		Strong: Sky!River92*Leaf
		Weak: Password
		"""
	help_text.visible = false
	$Control/RankingPanel/Help.connect("pressed", Callable(self, "_on_Help_pressed"))

# Final popup continue
	$Control/FinalPopup/Continue.connect("pressed", Callable(self, "_on_FinalPopup_Continue_pressed"))

#-----------------------------------------
#7. Accept / Reject logic
#-----------------------------------------
func _on_Accept_pressed(): 
	credential_panel.visible = false 
	feedback_panel.visible = true
	feedback_title.text = "Oh no — this alert was FAKE!"

func _on_Reject_pressed(): 
	credential_panel.visible = false 
	feedback_panel.visible = true
	feedback_title.text = "Great job!"
	feedback_body.text = """You correctly identified this alert as malicious.
		Click continue to try out a puzzle where we 
		rank the passwords!
		"""

#-----------------------------------------
#8. Continue → Ranking panel
#-----------------------------------------
func _on_Continue_pressed(): 
	feedback_panel.visible = false 
	ranking_panel.visible = true
#-----------------------------------------
#9. Ranking logic
#-----------------------------------------
func rank_password(button):
	if button in ranked: 
		return
	ranked[button] = current_rank
	button.text = str(current_rank) + ". " + button.text
	current_rank += 1

func _on_password1_pressed(): 
	rank_password(password1)
func _on_password2_pressed(): 
	rank_password(password2)
func _on_password3_pressed(): 
	rank_password(password3)
func _on_password4_pressed(): 
	rank_password(password4)
func _on_password5_pressed(): 
	rank_password(password5)

#-----------------------------------------
#10. Help toggle
#-----------------------------------------
func _on_Help_pressed(): 
	help_text.visible = !help_text.visible
	
#----------------------------------------
#11. Score Counter
#-----------------------------------------
func apply_global_score_for_passwords(player_order: Array) -> int: 
	var incorrect := 0
	for i in range(player_order.size()):
		if player_order[i] != correct_order[i]:
			incorrect += 1

	var global_points := 0

	match incorrect:
		0:
			global_points = 100
		1:
			global_points = 90
		2:
			global_points = 75
		3:
			global_points = 50
		4:
			global_points = 25
		_:
			global_points = -25

	Global.score += global_points
	return global_points

#-----------------------------------------
#12. Confirm ranking → Final popup
#-----------------------------------------
func _on_Confirm_pressed():
	var player_order = []
	var sorted_buttons = ranked.keys()
	sorted_buttons.sort_custom(func(a, b): return ranked[a] < ranked[b])

	for btn in sorted_buttons:
		player_order.append(btn.text.substr(btn.text.find(". ") + 2))

	var text = "Great job completing the password ranking!\n"
	text += "Correct strongest → weakest:\n"
	for p in correct_order:
		text += "• " + p + "\n"

	text += "\nYour ranking:\n"
	for p in player_order:
		text += "• " + p + "\n"

	# Declare ONCE
	var final_score = 0

	# If the player didn't rank all 5 passwords
	if player_order.size() < correct_order.size():
		final_score = -25
		Global.score += final_score
		text += "\nFinal Score: " + str(final_score) + "\n"
		final_body.text = text
		ranking_panel.visible = false
		final_popup.popup()
		return

	# Normal scoring
	final_score = apply_global_score_for_passwords(player_order)
	text += "\nFinal Score: " + str(final_score) + "\n"

	final_body.text = text
	ranking_panel.visible = false
	final_popup.popup()

#-----------------------------------------
#12. Final Continue → return to game
#-----------------------------------------
func _on_FinalPopup_Continue_pressed(): 
	Global.counter += 1
	print ("Global counter: ", Global.counter)
	print("Score is:", Global.score)
	Dialogic.VAR.chatstep += 1
	print("chat step: ",Dialogic.VAR.chatstep)
	$"../Player/CharacterBody2D/Playercamera2d".make_current()
	$Control/FinalPopup.visible = false
	$".".set_process(false)
