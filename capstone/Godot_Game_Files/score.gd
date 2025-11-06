extends Label
func _ready():
	# Set the initial score
	text = "score: $" + str(Global.score)
