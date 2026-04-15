extends Node
var score: int = 0

#EVENT TIME LINE DO NOT CHANGE! #EVENT TIME LINE DO NOT CHANGE! #EVENT TIME LINE DO NOT CHANGE! #EVENT TIME LINE DO NOT CHANGE! 
#EVENT TIME LINE DO NOT CHANGE! #EVENT TIME LINE DO NOT CHANGE! #EVENT TIME LINE DO NOT CHANGE! #EVENT TIME LINE DO NOT CHANGE! 
func _ready():
	$Player/CharacterBody2D/Playercamera2d.make_current()
	Dialogic.signal_event.connect(_on_dialogic_signal)
	$Event_Tree/Puzzles/EmailAlert.visible = false
	$Event_Tree/Puzzles/EmailAlert.set_process(false)
	
func _on_dialogic_signal(argument: String):
	if argument == "complete_chat1": 
		$Event_Tree/Puzzles/EmailAlert.set_process(true)
		$Event_Tree/Puzzles/EmailAlert.visible = true
	elif argument == "complete_chat2":
		$Event_Tree/Puzzles/EmailAlert.set_process(true)
		$Event_Tree/Puzzles/EmailAlert.visible = true
		$Event_Tree/Puzzles/EmailAlert.position = Vector2(357, 371)
	elif argument == "complete_chat3":
		$Event_Tree/Puzzles/EmailAlert.set_process(true)
		$Event_Tree/Puzzles/EmailAlert.visible = true
		$Event_Tree/Puzzles/EmailAlert.position = Vector2(237, 371)
	elif argument == "complete_chat4":
		$Event_Tree/Puzzles/EmailAlert.set_process(true)
		$Event_Tree/Puzzles/EmailAlert.visible = true
		$Event_Tree/Puzzles/EmailAlert.position = Vector2(-12, 371)
	elif argument == "complete_chat5":
		$"UsbPuzzle".activate()
	elif argument == "complete_chat6":
		get_tree().change_scene_to_file("res://Godot_Game_Files/endcutscene/lucy-player-boss-prehates.tscn")
		
		
func _process(_delta: float) -> void:
	if Global.counter == 1:
		$Event_Tree/Puzzles/EmailAlert.set_process(false)
		$Event_Tree/Puzzles/EmailAlert.visible = false
		$PhisingEmail.set_process(false)
		run_timeline()
		
	elif Global.counter == 3:
		$Event_Tree/Puzzles/EmailAlert.set_process(false)
		$Event_Tree/Puzzles/EmailAlert.visible = false
		$PhisingEmail.set_process(false)
		run_timeline()
		
	elif Global.counter == 4:
		$Event_Tree/Puzzles/EmailAlert.set_process(false)
		$Event_Tree/Puzzles/EmailAlert.visible = false
		$PhisingEmail.set_process(false)
		run_timeline()
		
	elif Global.counter == 6:
		$Event_Tree/Puzzles/EmailAlert.set_process(false)
		$Event_Tree/Puzzles/EmailAlert.visible = false
		$PhisingEmail.set_process(false)
		run_timeline()
		
	elif Global.counter == 8:
		$Event_Tree/Puzzles/EmailAlert.set_process(false)
		$Event_Tree/Puzzles/EmailAlert.visible = false
		$PhisingEmail.set_process(false)
		run_timeline()
	
func run_timeline():
	Dialogic.start("res://Godot_Game_Files/timeline.dtl")
	Global.counter += 1
	print("event counter: ", Global.counter)
	
