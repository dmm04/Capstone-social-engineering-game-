extends CharacterBody2D

@onready var anim_sprite: AnimatedSprite2D = $RadioBop

func _ready() -> void:
	anim_sprite.play("default")
