extends Control

# Notes:
# First, we make a condition where only if the start tutorial button is pressed,
# only then the tutorial sequence starts playing.
# We add a back and next button instead of just "space to continue" because
# some people might accidentally press continue, coudln't step back,
# and has to repeat through the whole sequence of the tutorial again.

# Talking about sequence of the tutorial, we can use a similar mechanic in wave_bottom.gd - states

# Code to start tutorial

@onready var start_tutorial = $"Start Tutorial"

@onready var dialogue = $Dialogue
@onready var back_button = $"Back Button"
@onready var next_button = $"Next Button"
@onready var text_box = $"Text Box"

@onready var tutor_desc = $"Tutorial Description"
@onready var tutor_desc_2 = $"Tutorial Description 2"

@onready var arrow1 = $Arrow
@onready var arrow2 = $"Arrow 2"
@onready var arrow3 = $"Arrow 3"
@onready var arrow4 = $"Arrow 4"
@onready var box1 = $Box
@onready var box2 = $"Box 2"

@onready var game = $/root/Node2D
@onready var animation = get_node("/root/Node2D/Strandbeest/AnimatedSprite2D")
@onready var strandbeest = get_node("/root/Node2D/Strandbeest")

@onready var purchase = $Purchase
@onready var click = $Click
@onready var bye = $Bye
@onready var vineboom = $/root/Node2D/VineBoom

var tutorial_playing: bool = false
var _state: String = "Phase 1"

func _ready() -> void:
	arrow1.visible = false
	arrow2.visible = false
	arrow3.visible = false
	arrow4.visible = false
	box1.visible = false
	box2.visible = false
	dialogue.visible = false
	text_box.visible = false
	back_button.visible = false
	next_button.visible = false
	start_tutorial.pressed.connect(_on_start_tutorial_pressed)
	back_button.pressed.connect(_back_button_pressed)
	next_button.pressed.connect(_next_button_pressed)


func _on_start_tutorial_pressed() -> void:
	click.play()
	game.restart_game()
	tutorial_playing = true
	_state = "State 1"
	text_box.fade_in()
	dialogue.fade_in()
	next_button.fade_in()
	back_button.fade_in()
	tutor_desc.visible = false
	tutor_desc_2.visible = false
	update_display()

# We must use [func] block so that the button has something to connect to,
# [variable name for node (from @onready var ... = $(node name)).pressed.connect(function)]

# We cannot just use:
# if next_button.pressed:
# 	_state = "Phase 2"
# because a button needs to connect to a function as said earlier.

# Each button would also have its own specific function, so we need 2 seperate functions.
# One function for when the player presses back button and another for next button.


func _back_button_pressed() -> void:
	click.play()
	match _state:
		"State 1":
			_state = "End State"
			bye.play()
		"State 2":
			_state = "State 1"
		"State 3":
			_state = "State 2"
		"State 4":
			_state = "State 3"
			arrow1.fade_out()
		"State 5":
			_state = "State 4"
			arrow1.fade_in()
			arrow2.fade_out()
		"State 6":
			_state = "State 5"
			arrow2.fade_in()
		"State 7":
			_state = "State 6"
			arrow3.fade_out()
		"State 8":
			_state = "State 7"
			arrow3.fade_in()
			arrow4.fade_out()
		"State 9":
			_state = "State 8"
			arrow4.fade_in()
			box1.fade_out()
		"State 10":
			_state = "State 9"
			box1.fade_in()
		"State 11":
			_state = "State 10"
		"State 12":
			_state = "State 11"
		"State 13":
			_state = "State 12"
		"State 14":
			_state = "State 13"
			box2.fade_out()
		"State 15":
			_state = "State 14"
			box2.fade_in()
		"State 16":
			_state = "State 15"
	update_display()


func _next_button_pressed() -> void:
	click.play()
	match _state:
		"State 1":
			_state = "State 2"
		"State 2":
			_state = "State 3"
		"State 3":
			_state = "State 4"
			arrow1.fade_in()
		"State 4":
			_state = "State 5"
			arrow1.fade_out()
			arrow2.fade_in()
		"State 5":
			_state = "State 6"
			arrow2.fade_out()
		"State 6":
			_state = "State 7"
			arrow3.fade_in()
		"State 7":
			_state = "State 8"
			arrow3.fade_out()
			arrow4.fade_in()
		"State 8":
			_state = "State 9"
			arrow4.fade_out()
			box1.fade_in()
		"State 9":
			_state = "State 10"
		"State 10":
			_state = "State 11"
		"State 11":
			_state = "State 12"
			box1.fade_out()
		"State 12":
			_state = "State 13"
		"State 13":
			_state = "State 14"
			box2.fade_in()
		"State 14":
			_state = "State 15"
			box2.fade_out()
		"State 15":
			_state = "State 16"
			bye.play()
		"State 16":
			_state = "End State"
	update_display()


func update_display() -> void:
	dialogue.visible = true
	match _state:
		"State 1":
			dialogue.text = "Hello player, welcome to Strandbeest Game! I am Mr Crabs."

		"State 2":
			dialogue.text = "This game's theme revolves around Strandbeests, made by Theo Jansen."

		"State 3":
			dialogue.text = "Let me show you around here first..."
			
		"State 4":
			dialogue.text = "The clouds down here is you..."
			
		"State 5":
			dialogue.text = "... and by using your [ SPACE ] key, you shoot winds at this Strandbeest."
			
		"State 6":
			dialogue.text = "For each wind charge you shoot at them, the Strandbeest gains some movement speed."
			
		"State 7":
			dialogue.text = "You need to get the Strandbeest to walk past the finish line as soon as possible, if you do so in under 45 seconds..."
			
		"State 8":
			dialogue.text = "... you get 50 pipes!! If you don't, you only get 25 pipes."
			
		"State 9":
			dialogue.text = "Pipes is the in-game currency, it can be used to spend on upgrades."
			
		"State 10":
			dialogue.text = "These upgrade will then help you by lowering the difficulty through out the game."
			
		"State 11":
			dialogue.text = "The max level for each upgrade is 5, so once you have gotten all upgrades, you have officially completed the game."
			
		"State 12":
			dialogue.text = 'Earlier you questioned, "Getting the Strandbeest to the other side as soon as possible? What is the trade off?"'
		
		"State 13":
			dialogue.text = "Well, if you make it go too fast, the Strandbeest can break."
			vineboom.play()
		"State 14":
			dialogue.text = "To reset after each round, you could either press [ R ] key or press this restart button."
		
		"State 15":
			dialogue.text = "I believe thats all from me, be sure to have some fun playing this game!"
			strandbeest.reset_round()
			
		"State 16":
			dialogue.text = "This is the end of the tutorial. Have fun playing!"

		"End State":
			next_button.fade_out()
			back_button.fade_out()
			dialogue.fade_out()
			text_box.fade_out()
			tutorial_playing = false
