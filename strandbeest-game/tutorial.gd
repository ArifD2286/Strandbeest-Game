extends Control

# Notes:
# First, we make a condition where only if the start tutorial button is pressed,
# only then the tutorial sequence starts playing.
# We add a back and next button instead of just "space to continue" because
# some people might accidentally press continue, coudln't step back,
# and has to repeat through the whole sequence of the tutorial again.

# Talking about sequence of the tutorial, we can use a similar mechanic in wave_bottom.gd - states

# Code to start tutorial
@onready var dialogue = $Dialogue
@onready var back_button = $"Back Button"
@onready var next_button = $"Next Button"
@onready var start_tutorial = $"Start Tutorial"
@onready var text_box = $"Text Box"

var tutorial_playing: bool = false
var _state: String = "Phase 1"

func _ready() -> void:
	dialogue.visible = false
	text_box.visible = false
	back_button.visible = false
	next_button.visible = false
	start_tutorial.pressed.connect(_on_start_tutorial_pressed)
	back_button.pressed.connect(_back_button_pressed)
	next_button.pressed.connect(_next_button_pressed)


func _on_start_tutorial_pressed() -> void:
	tutorial_playing = true
	_state = "State 1"
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
	match _state:
		"State 2":
			_state = "State 1"
		"State 3":
			_state = "State 2"
		"State 4":
			_state = "State 3"
	update_display()


func _next_button_pressed() -> void:
	match _state:
		"State 1":
			_state = "State 2"
		"State 2":
			_state = "State 3"
		"State 3":
			_state = "State 4"
		"State 4":
			_state = "End State"
	update_display()

func update_display() -> void:
	dialogue.visible = true
	text_box.visible = true
	match _state:
		"State 1":
			next_button.visible = true
			back_button.visible = false
			dialogue.text = "Hello player, welcome to Strandbeest Game! I am Mr Crabs."

		"State 2":
			next_button.visible = true
			back_button.visible = true
			dialogue.text = "This game's theme revolves around Strandbeests!"

		"State 3":
			next_button.visible = true
			back_button.visible = true
			dialogue.text = "So the way the game works..."

		"State 4":
			next_button.visible = true
			back_button.visible = true
			dialogue.text = "This is the end of the tutorial. Have fun playing!"

		"End State":
			next_button.visible = false
			back_button.visible = false
			dialogue.visible = false
			text_box.visible = false
			tutorial_playing = false
