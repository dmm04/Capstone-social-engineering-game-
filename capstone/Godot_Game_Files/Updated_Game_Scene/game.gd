extends Node2D

@onready var alert_icon = $Alert # Path to your alert icon node

# Define four possible positions
var alert_positions = [
	Vector2(24, 430),
	Vector2(144, 430),
	Vector2(270, 430),
	Vector2(394, 430)
]

func _ready():
	randomize()
	show_alert_icon()

func show_alert_icon() -> void:
	var random_index = randi() % alert_positions.size()
	alert_icon.position = alert_positions[random_index]
	alert_icon.visible = true  # Make sure it's visible
