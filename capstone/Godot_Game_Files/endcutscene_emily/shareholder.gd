extends Node2D

var is_pre_dialogue = true
var is_throwing = false

func _ready():
	pass

func walk():
	$member.play("walk")
	$member2.play("walk")
	$member3.play("walk")
	$member4.play("walk") 

func _process(delta):
	pass
	if is_pre_dialogue:
		if $member.position.x < 250 and $member2.position.x < 250 and $member3.position.x < 250 and $member4.position.x < 250  :
			$member.position.x += 200 * delta
			$member2.position.x += 200 * delta
			$member3.position.x += 200 * delta
			$member4.position.x += 200 * delta
		else:
			$member.play("stand")
			$member2.play("stand")
			$member3.play("stand")
			$member4.play("stand")
	if is_throwing:
		return

# -------------------------
# WALK TO DEVIL (group movement)
# -------------------------
func walk_to_devil(devil_node):
	is_throwing = true

	# Stoping around the devil
	var target_x = devil_node.global_position.x - 150

	# Play walk animations
	$member.play("walk")
	$member2.play("walk")
	$member3.play("walk")
	$member4.play("walk")

	# Move the WHOLE group as one
	var t = create_tween()
	t.tween_property(self, "global_position:x", target_x, 2.0)

	return t


# -------------------------
# FULL THROW SEQUENCE
# -------------------------
func throw_devil(devil_node):
	is_throwing = true

	# 1. Walk to the devil
	var t1 = walk_to_devil(devil_node)
	await t1.finished

	# Switch to standing animation
	$member.play("stand")
	$member2.play("stand")
	$member3.play("stand")
	$member4.play("stand")

	# 2. Snap devil onto the shareholders
	devil_node.global_position = self.global_position + Vector2(0,200)

	# 3. Devil falls immediately
	var t3 = create_tween()
	t3.tween_property(devil_node, "global_position:y", devil_node.global_position.y + 500, 3.0)
	await t3.finished

	# 4. Hide devil
	devil_node.visible = false
