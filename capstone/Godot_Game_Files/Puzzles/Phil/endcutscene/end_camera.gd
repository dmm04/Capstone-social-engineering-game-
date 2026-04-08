extends Camera2D

@export var target_x := 120
@export var speed := 200
func _ready():
	make_current()
	print("Camera is current:", is_current())
func _process(delta):
	if Dialogic.VAR.get("end_step") == 1:
		var cam_global := global_position
		cam_global.x += speed * delta
		global_position = cam_global

		if global_position.x >= target_x:
			Dialogic.VAR.set("end_step", 2)
			Dialogic.timeline_continue()  # resume timeline
