extends Camera2D

@export var camera_move_distance := 200.0
@export var camera_speed := 200.0

@onready var change_effect = $"../boss/change_effect"
@onready var change_effect2 = $"../boss/change_effect2"
@onready var boss_end = $"../boss/boss_end"
@onready var boss_devil = $"../boss/boss_devil"
@onready var portal = $"../mainchar/portal"

var camera_target_x := 0.0
var moving_camera := false

func _ready():
	make_current()
	boss_devil.visible = false
	change_effect.visible = false
	change_effect2.visible = false
	portal.visible = false
	camera_target_x = global_position.x

func _process(delta):
	var step = Dialogic.VAR.get("end_step")
	
	# Step 1: Start camera movement once
	if step == 1 and not moving_camera:
		camera_target_x = global_position.x + camera_move_distance
		moving_camera = true

	# Move the camera every frame until it reaches target
	if moving_camera:
		global_position.x = min(global_position.x + camera_speed * delta, camera_target_x)
		if global_position.x >= camera_target_x:
			moving_camera = false
			Dialogic.VAR.set("end_step", 2)
			await get_tree().process_frame
			Dialogic.start("res://Godot_Game_Files/endcutscene/timeline.dtl")  # replace with your dialog name

	# Step 3: Boss transformation
	if step == 3:
		await _step3_boss_transform()

	# Step 5: Final portal animation
	if step == 5:
		await _step5_final_portal()


# Boss transformation
func _step3_boss_transform() -> void:
	# Show spin effects
	change_effect.visible = true
	change_effect2.visible = true
	change_effect.play("spin")
	change_effect2.play("spin")

	# Wait 3.5 seconds (adjust as needed)
	await get_tree().create_timer(3).timeout

	# Hide effects and transform boss
	change_effect.visible = false
	change_effect2.visible = false
	boss_end.visible = false
	boss_devil.visible = true
	boss_devil.play("idle")
	Dialogic.VAR.set("end_step", 4)
	Dialogic.start("res://Godot_Game_Files/endcutscene/timeline.dtl")

# Final portal animation
func _step5_final_portal() -> void:
	portal.visible = true
	portal.play("spin")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene("res://NextScene.tscn")
