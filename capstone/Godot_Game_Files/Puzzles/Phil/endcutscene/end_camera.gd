extends Camera2D

@export var target_x := 120
@export var speed := 200

func _process(delta):
	if Dialogic.VAR.get("end_step") == 1:
		if position.x < target_x:
			position.x += speed * delta
			
		else:
			pass
		Dialogic.VAR.set("end_step", 1.1)
		Dialogic.start("endcutscene/timeline")
