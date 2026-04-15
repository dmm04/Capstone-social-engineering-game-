extends Node2D

@onready var scroll = $CanvasLayer/Scroll
@onready var music = $AudioStreamPlayer

var speed := 55.0
var drift := 0.0
var skipped := false

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		skip()

	if skipped:
		return

	scroll.position.y -= speed * delta

	# cinematic sway
	drift += delta
	scroll.position.x = sin(drift * 0.6) * 12

	if scroll.position.y < -2200:
		end()

func skip():
	if skipped:
		return
	skipped = true
	end()

func end():
	get_tree().change_scene_to_file("res://MainMenu.tscn")
