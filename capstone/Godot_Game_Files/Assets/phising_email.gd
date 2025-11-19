extends Node2D


var messages = [
		"""
Dear Valued Customer,
We noticed suspicious activity on your account of magical creatures.
Please confirm your rainbow code and billing at [FAKE-LINK] immediately.
Failure to respond will result in loss of your sparkles.
Click the glowing button to avoid disappointment.
Sincerely, The Unicorn Billing Team
""",
		"""
Dear Valued Customer,
We noticed suspicious activity on your account of magical creatures.
Please confirm your rainbow code and billing at [FAKE-LINK] immediately.
Failure to respond will result in loss of your sparkles.
Click the glowing button to avoid disappointment.
Sincerely, The Unicorn Billing Team
""",
		"""
Hi Team,
Payroll encountered a tiny gremlin causing deposits to move to a different planet.
To re-route your pay, reply with your bank routing number and "magical code."
We promise this is secure (definitely).
Thanks for your cooperation, Payroll Ops
""",
		"""
Dear User,
We tried to send you a message but your mailbox is full of confetti.
Click [FAKE-LINK] to clear the confetti and verify your account now.
If you do nothing, a mysterious raccoon will take your username.
Cheers, Account Preservation Squad
""",
		"""
Hey,
It's me, your coworker (maybe). I'm stranded on the moon and need $200.
Please Venmo to @moon-rescue or reply with card details.
I'll pay you back with lunar selfies.
Thanks!!
"""
	]

var emails = ["""hotdogwarrior@hotdot.com""","""hr@workofice.com""","""dragonmaster302@yawho.com""","""gregk@worckoffice.com""","""Ilostmyhat@hatlover.com"""]

# Cache node references (change names if your scene uses different ones)


func _ready() -> void:
	initialize()
	
func reset_alert() -> void:
	initialize()

func initialize():
	randomize()  # seed RNG
	_show_random_email()
	$Button_manager/Accept.visible = true
	$Button_manager/Reject.visible = true
	$Button_manager/Help.visible = true
	$Button_manager/Continue.visible = false
	$Button_manager/Help/Label.text = "⚠️ Watch for common phishing signs:
• Urgent or threatening language
• Requests for passwords or payment info
• Strange links or unknown senders
• Poor spelling, odd formatting, or suspicious attachments
Never share sensitive info through email.
"
	
func _show_random_email() -> void:
	$PhisingEmail/message.text = messages.pick_random()
	$PhisingEmail/email.text = "FROM: " + emails.pick_random()
	
func _on_accept_pressed() -> void:
	$Button_manager/Continue/Label2.text = "WRONG! Never trust an email asking for credit card information.
	Always look who is sending it and make sure you know them."
	$Button_manager/Accept.visible = !$Button_manager/Accept.visible
	$Button_manager/Reject.visible = !$Button_manager/Reject.visible
	$Button_manager/Help.visible = !$Button_manager/Help.visible
	$Button_manager/Continue.visible = !$Button_manager/Continue.visible
	print("Score is:", Global.score)
	Global.score -= 100
	
func _on_continue_pressed() -> void:
	Global.counter += 1
	print ("event counter: ", Global.counter)
	print("Score is:", Global.score)
	Dialogic.VAR.chatstep += 1
	print("chat step: ",Dialogic.VAR.chatstep)
	$"../Player/CharacterBody2D/Playercamera2d".make_current()
	$".".set_process(false)

func _on_reject_pressed() -> void:
	$Button_manager/Continue/Label2.text = "CORRECT! Never trust an email asking for credit card information.
	Always look who is sending it and make sure you know them."
	$Button_manager/Accept.visible = !$Button_manager/Accept.visible
	$Button_manager/Reject.visible = !$Button_manager/Reject.visible
	$Button_manager/Help.visible = !$Button_manager/Help.visible
	$Button_manager/Continue.visible = !$Button_manager/Continue.visible
	print("Score is:", Global.score)
	Global.score += 100

func _on_help_pressed() -> void:
	$Button_manager/Help/Label.visible = !$Button_manager/Help/Label.visible
