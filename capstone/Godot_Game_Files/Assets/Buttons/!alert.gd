extends Area2D

@onready var sprite = $AnimatedSprite2D
var player_in_area = false

func _ready():
	# Start the popup animation
	sprite.play("float")

# Must include delta parameter to match parent signature
func _process(_delta: float):
	if player_in_area and Input.is_action_just_pressed("interact"):
		open_puzzle_scene()
	
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
