extends CharacterBody2D

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var alert_sound: AudioStreamPlayer = $AlertSound
@onready var area: Area2D = $Area2D

func _ready():
	# Connect the signal once
	anim_sprite.connect("animation_finished", Callable(self, "_on_animation_finished"))
	

	# Play popup animation and sound
	anim_sprite.play("popup")

func _on_animation_finished():
	if anim_sprite.animation == "popup":
		anim_sprite.play("hover")


	
