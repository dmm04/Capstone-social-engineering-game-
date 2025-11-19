extends Area2D

@onready var sprite = $AnimatedSprite2D
@onready var message_label = $AlertLabel

var player_in_area2 := false
var continue_chat = 0 

func _ready():
	# Start the popup animation
	sprite.play("float")
	'''
# Must include delta parameter to match parent signature
func _process(_delta: float) -> void:
	# Only check for interact press if player is in the area
	if Global.counter == 0:
		if player_in_area2 and Input.is_action_just_pressed("interact"):
			continue_text()
			continue_chat = 1
	elif Global.counter == 3:
		self.visible = true
		$"../Label".text = "Well I hope you learned something."
		if player_in_area2 and Input.is_action_just_pressed("interact"):
			print("Counter advanced to:", Global.counter)
			chat_3()
			

func chat_3():
	if continue_chat == 4:
		$"../Label".text ="I heard rumor of a shadowy character running around plugging in usb's into systems. Quickly go find it before the system is compromised!"
		chat_close()

func chat_close():
	if player_in_area2 and Input.is_action_just_pressed("interact"):
		$"../Label".visible = false
		$".".visible = false
		$"../Chatbubble".visible = false 
		Global.counter += 1
		print("event counter: ", Global.counter)

func _on_body_entered(_body):
		player_in_area2 = true
		message_label.visible = true
		print("Body Entered chat area")

func _on_body_exited(_body):
		player_in_area2 = false
		message_label.visible = false

func continue_text():
	$"../Label".text = "When you see a ! above your coworkers, you need to go check out thier computer and complete the cybersecurity task! Good luck! DONT DISAPOINT ME."
	continue1() 
	
func continue1():  
	if player_in_area2 and Input.is_action_just_pressed("interact"):
		continue_chat += 1
		if continue_chat == 2:
			$"../Label".visible = false
			$".".visible = false
			$"../Chatbubble".visible = false 
			Global.counter += 1
			print ("event counter: ", Global.counter)

	'''
