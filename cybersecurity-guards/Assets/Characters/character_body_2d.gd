extends CharacterBody2D

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	# Idle animation
	anim_sprite.play("idle")
