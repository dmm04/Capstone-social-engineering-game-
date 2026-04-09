extends Area2D

@onready var sprite = $AnimatedSprite2D
var player_in_area = false

func _ready():
	# Start the popup animation
	sprite.play("float")

# Must include delta parameter to match parent signature
func _process(_delta: float):
	if player_in_area and Input.is_action_just_pressed("interact"):
		if Global.counter < 3:
			open_puzzle_scene()
		elif Global.counter == 5:
			open_emilys_puzzle()
		elif Global.counter == 6:
			open_emilys_puzzle()
		elif Global.counter == 7:
			open_password_puzzle()
			
			
			
			
func _on_body_entered(_body):
		player_in_area = true
		$AlertLabel.visible = true
		print("Body Entered")

func _on_body_exited(_body):
		player_in_area = false
		$AlertLabel.visible = false

func open_puzzle_scene():
	$"../../../PhisingEmail".set_process(true)
	$"../../../PhisingEmail".reset_alert()
	$"../../../PhisingEmail/phisingemailcamera2d".make_current()

func open_emilys_puzzle():
	$"../../../malicious_files".set_process(true)
	$"../../../malicious_files".initialize()
	$"../../../malicious_files/EmilysCamera2D".make_current()
	
func open_password_puzzle():
	$"../../../password_reset".set_process(true)
	$"../../../password_reset".initialize()
	$"../../../password_reset/Camera2D".make_current()



func stop():
	self.set_process(false)      
	self.set_physics_process(false) 
