extends Node
var score: int = 0
var counter: int = 0

var puzzle_active: bool = false
var chatstep: int = 0

func endcredits():
	get_tree().change_scene_to_file("res://end_credits.tscn")
