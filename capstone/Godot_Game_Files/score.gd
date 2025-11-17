extends Label

#Keep the score updated boi
func _process(_delta: float) -> void:
	text = "score: $" + str(Global.score)
