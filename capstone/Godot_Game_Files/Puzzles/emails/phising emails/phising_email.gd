extends Node2D


func _on_accept_pressed() -> void:
	get_tree().change_scene_to_file("res://Godot_Game_Files/game.tscn")


func _on_reject_pressed() -> void:
	get_tree().change_scene_to_file("res://Godot_Game_Files/game.tscn")


func _on_help_pressed() -> void:
	$Button_manager/Help/Label.visible = !$Button_manager/Help/Label.visible
