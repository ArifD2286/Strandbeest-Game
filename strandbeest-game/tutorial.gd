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

@onready var purchase = $Purchase
@onready var click = $Click
@onready var bye = $Bye

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
		"State 2":
			_state = "State 1"
		"State 3":
			_state = "State 2"
		"State 4":
			_state = "State 3"
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
		"State 4":
			_state = "End State"
	update_display()

func update_display() -> void:
	dialogue.visible = true
	match _state:
		"State 1":
			dialogue.text = "Hello player, welcome to Strandbeest Game! I am Mr Crabs."

		"State 2":
			dialogue.text = "This game's theme revolves around Strandbeests! You can watch some videos online about them."

		"State 3":
			dialogue.text = "Let me show you around here first..."

		"State 4":
			dialogue.text = "This is the end of the tutorial. Have fun playing!"
			bye.play()

		"End State":
			next_button.fade_out()
			back_button.fade_out()
			dialogue.fade_out()
			text_box.fade_out()
			tutorial_playing = false
