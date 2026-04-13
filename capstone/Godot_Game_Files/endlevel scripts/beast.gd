extends Area2D

@export var rise_speed: float = 40.0
@export var acceleration: float = 0.0

var current_speed: float

func _ready():
	current_speed = rise_speed
	body_entered.connect(_on_body_entered)

func _process(delta):
	position.y -= current_speed * delta
	current_speed += acceleration * delta

func _on_body_entered(body):
	if body.name == "Player":
		body.die()
