extends Area2D

@onready var sprite = $AnimatedSprite2D
@onready var message_label = $AlertLabel

var player_in_area2 := false
var continue_chat = 0 

func _ready():
	# Start the popup animation
	sprite.play("float")
	$AlertLabel.visible = false
	$"../../Alert".set_process(false)


# Must include delta parameter to match parent signature
func _process(delta: float) -> void:
	# Only check for interact press if player is in the area
	if player_in_area2 and Input.is_action_just_pressed("interact"):
		continue_text()
		continue_chat = 1
	

func _on_body_entered(body):
		player_in_area2 = true
		message_label.visible = true
		print("Body Entered")

func _on_body_exited(body):
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
			$"../../Alert".set_process(true)
			$"../../Alert".visible =true
	
