extends Area2D

# I swear this should be simpler than it is
func _on_body_entered(body):
	if body.name == "Player":
		body.die()  # assuming the player has a die() function
