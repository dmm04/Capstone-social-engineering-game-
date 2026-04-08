extends Node2D

func _ready():
	# Play immediately
	$AnimatedSprite2D.play("intro")

	# Use BOTH of these connections for safety:
	$AnimatedSprite2D.animation_finished.connect(_on_intro_done)
	$AnimatedSprite2D.frame_changed.connect(_check_if_last_frame)

# This runs when the animation ends normally:
func _on_intro_done():
	print("Intro finished!")  # You should see this in the debugger
	get_tree().change_scene_to_file("res://MainGame.tscn")

# This forces it to continue even if Godot gets stuck on the last frame:
func _check_if_last_frame():
	var sprite = $AnimatedSprite2D
	if sprite.frame == sprite.sprite_frames.get_frame_count("intro") - 1:
		print("Reached last frame manually")
		get_tree().change_scene_to_file("res://MainGame.tscn")
