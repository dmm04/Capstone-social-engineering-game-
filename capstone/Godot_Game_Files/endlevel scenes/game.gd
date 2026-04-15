extends Node2D

@onready var intro_cutscene = $CanvasLayer/IntroCutscene
@onready var player = $Player
@onready var rising_hazard = $RisingHazard
@onready var enemies = $enemies

var intro_playing = true

func _ready():
	# Hide/disable gameplay while intro runs
	player.process_mode = Node.PROCESS_MODE_DISABLED
	rising_hazard.process_mode = Node.PROCESS_MODE_DISABLED
	enemies.process_mode = Node.PROCESS_MODE_DISABLED

	player.visible = false

	intro_cutscene.visible = true
	intro_cutscene.play("intro")

	intro_cutscene.animation_finished.connect(_on_intro_finished)

func _on_intro_finished():
	intro_playing = false

	intro_cutscene.visible = false
	$ENDZONE/portal.play("default")
	player.visible = true
	player.process_mode = Node.PROCESS_MODE_INHERIT
	rising_hazard.process_mode = Node.PROCESS_MODE_INHERIT
	enemies.process_mode = Node.PROCESS_MODE_INHERIT
