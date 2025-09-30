extends CharacterBody2D

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED: float = 150.0
const JUMP_FORCE: float = -400.0
const GRAVITY: float = 28.0

var last_dir := 1  # 1 = right, -1 = left

func _physics_process(delta):
	# Handle input
	var input_dir := 0
	
	if Input.is_action_pressed("ui_right"):
		input_dir += 1
	if Input.is_action_pressed("ui_left"):
		input_dir -= 1

	# Track last direction
	if input_dir != 0:
		last_dir = input_dir

	# Apply horizontal velocity
	velocity.x = input_dir * SPEED

	# Jump
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_FORCE

	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY

	# Choose animation
	if not is_on_floor():
		if velocity.x > 0:
			anim_sprite.play("jump right")
			anim_sprite.flip_h = false
		elif velocity.x < 0:
			anim_sprite.play("jump left")
			anim_sprite.flip_h = false
		else:
			anim_sprite.play("idle")
			anim_sprite.flip_h = last_dir < 0
	else:
		if velocity.x > 0:
			anim_sprite.play("walk right")
			anim_sprite.flip_h = false
		elif velocity.x < 0:
			anim_sprite.play("walk left")
			anim_sprite.flip_h = false
		else:
			anim_sprite.play("idle")
			anim_sprite.flip_h = last_dir < 0

	# Move the character
	move_and_slide()
