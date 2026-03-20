extends Node2D
func _ready():
	$mainchar/player.play("walk")
	create_tween().tween_property($mainchar/player, "position:x", 1300, 3).finished.connect(func():
		$mainchar/player.play("idle")
	)

	$lady/lucy.play("walk")
	create_tween().tween_property($lady/lucy, "position:x", 1300, 3).finished.connect(func():
		$lady/lucy.play("idle")
		Dialogic.start("endcutscene/timeline")
	)

	
