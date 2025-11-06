extends Area2D

@onready var sprite = $AnimatedSprite2D

var player_in_area = false

func _ready():
	# Start the popup animation
	sprite.play("float")
	$AlertLabel.visible = false

# Must include delta parameter to match parent signature
func _process(delta: float) -> void:
	# Only check for interact press if player is in the area
	if player_in_area and Input.is_action_just_pressed("interact"):
		open_puzzle_scene()

func _on_body_entered(body):
		player_in_area = true
		$AlertLabel.visible = true
		print("Body Entered")

func _on_body_exited(body):
		player_in_area = false
		$AlertLabel.visible = false

func open_puzzle_scene():
	get_tree().change_scene_to_file("res://Godot_Game_Files/Puzzles/emails/phising emails/phising_email.tscn")
