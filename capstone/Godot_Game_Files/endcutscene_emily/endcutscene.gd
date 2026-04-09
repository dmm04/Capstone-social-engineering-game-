extends Node2D

func _ready():
	Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)
	
	$mainchar/portal.play("default")
	$boss/boss_devil.play("idle")
	$lady/lucy.play("idle")
	$mainchar/player.play("fall")

	var start_y = $mainchar/player.position.y
	var end_y = start_y + 130

	var t = create_tween()
	t.tween_property($mainchar/player, "position:y", end_y, 0.8).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	await t.finished
	
	await $mainchar/player.animation_finished
	$mainchar/player.play("idle")
	$mainchar/portal.visible = false
	
	$shareholder.walk()
	await get_tree().create_timer(5.5).timeout
	$shareholder.is_pre_dialogue = false

	Dialogic.start("emilyendscene")
	
func _on_dialogic_timeline_ended():
	_start_throw_sequence()

func _start_throw_sequence():
	# Tell the shareholder script to begin the throw
	$shareholder.throw_devil($boss/boss_devil)
