extends Area2D

signal alert_clicked  # Optional: signal to notify parent/main scene

func _ready() -> void:
	input_pickable = true  # Required in Godot 4.x to receive input events

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Alert icon clicked!")
		emit_signal("alert_clicked")  # Optional: notify parent
