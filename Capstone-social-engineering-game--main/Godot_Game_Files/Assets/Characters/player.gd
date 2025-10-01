extends CharacterBody2D

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 150
const JUMP_FORCE = -400
const GRAVITY = 25

func _physics_process(delta):
	var input_dir = 0
	if Input.is_action_pressed("ui_right"):
		input_dir += 1
	if Input.is_action_pressed("ui_left"):
		input_dir -= 1

	velocity.x = input_dir * SPEED

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_FORCE

	if not is_on_floor():
		velocity.y += GRAVITY

	if not is_on_floor():
		if velocity.x > 0:
			anim_sprite.play("jump right")
		elif velocity.x < 0:
			anim_sprite.play("jump left")
		else:
			anim_sprite.play("idle")
	else:
		if input_dir > 0:
			anim_sprite.play("walk right")
		elif input_dir < 0:
			anim_sprite.play("walk left")
		else:
			anim_sprite.play("idle")

	move_and_slide()
