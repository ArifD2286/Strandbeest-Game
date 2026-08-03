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


var tutorial_playing: bool = false
var _state: String = "Tutorial finished"


func _ready() -> void:
	dialogue.visibile = false
	back_button.visible = false
	next_button.visible = false
	
func _process(delta: float) -> void:
	if start_tutorial.pressed:
		tutorial_playing = true
	if tutorial_playing == true:
		match _state:
			"Phase 1":
				dialogue.visible = true
				next_button.visible = true
				dialogue.text = "Hello player, welcome to Strandbeest Game! I am Mr Crabs but you can call me ..."
				if next_button.pressed:
					_state = "Phase 2"
			"Phase 2":
				dialogue.visible = true
				next_button.visible = true
				back_button.visible = true
				dialogue.text = "This game "
				
