extends Node2D  # This script is attached to the MainScene node (root of the scene)

# Get a reference to the sprite that will pop up
@onready var Alert = $Alert 

# Define a list of positions where the popup can appear
var positions = [
	Vector2(0, 0),
	Vector2(0, 128),
	Vector2(0, 251),
	Vector2(0, 374)
]

func _ready():
	# This function runs once when the scene starts
	Alert.hide()               # Make sure the popup is hidden at the start
	start_random_timer()       # Start the timer that will make the popup appear randomly

func start_random_timer():
	# Create a new timer node
	var timer = Timer.new()
	# Add the timer as a child so it runs in the scene
	add_child(timer)
	timer.one_shot = true      # The timer will only trigger once (not repeat automatically)
	timer.wait_time = randf_range(5, 9)  # Random delay between 2 and 5 seconds
	# Connect the timer's "timeout" signal to a function that handles showing the popup
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	
	timer.start()              # Start the timer

func _on_timer_timeout():
	# This function is called when the timer finishes counting down
	# Pick a random position from the list and move the popup there
	Alert.position = positions.pick_random()
	Alert.show()               # Make the popup visible
	start_random_timer()       # Restart the timer for the next random popup
