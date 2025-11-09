# Cybersecurity Game – Puzzles

This folder contains all **puzzle scenes** for the cybersecurity learning game.  
Each puzzle is a self-contained Godot scene (`.tscn`) that can be loaded randomly when the player interacts with a computer in the main game world.

---

## Purpose
The puzzles are designed to:
- Teach cybersecurity concepts through interactive challenges.
- Provide variety.

---

## Structure
- Each puzzle is saved as its own `.tscn` file inside this folder.
- Puzzle scenes are independent and should not rely on external scripts if we can. Assets can be used. 
- A central Puzzle Manager script chooses one puzzle at random when triggered in the main game.
- Put your puzzle in a sub folder along with any assets for that puzzle. 
- IMPORTANT! Name your puzzle Puzzle# with the # reflecting whatever # it is in order. This has to be done in order to find it when we randomly select a puzzle. 

Example folder layout:
puzzles/
 ├── password_strength/
 │    ├── password_strength.tscn
 │    ├── password_strength.gd
 │    └── assets/ (optional: images, sounds)
 │
 ├── phishing_emails/
 │    ├── phishing_emails.tscn
 │    ├── phishing_emails.gd

 │    └── assets/


Code for returning to office scene from puzzle:

@onready var return_button = $ReturnButton
func _ready():
 return_button.connect("pressed", Callable(self, "_on_return_pressed"))
	return_button.tooltip_text = "Close this window and return to office."

func _on_return_pressed():
 get_tree().change_scene_to_file("res://Godot_Game_Files/game.tscn")
