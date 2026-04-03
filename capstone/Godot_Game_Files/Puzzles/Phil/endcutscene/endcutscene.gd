extends Node2D
func _ready():
	$mainchar/player.play("fall")
	$mainchar/player.play("idle")
	Dialogic.start("endcutscene/emilyendscene")
	


	
