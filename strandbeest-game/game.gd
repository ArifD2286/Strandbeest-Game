extends Node2D

# Notes:
# game.gd / the script attached to Node2D acts as a refree, it needs to know and processes what happened and reacted.

# Its job is to:
# - Know when a round starts
# - Know when a round ends - either from winning (strandbeest crosses line) OR losing (strandbeest tipping over).
# - Show end of a round message, varies from condition. (show game over and 0 pipes is gained when losing,
# and either 25 or 50 pipe is gained)

# The amount of pipes gained by a player varies with their winning time, the longer they took for the strandbeest to cross
# the line, the lower they get. But to keep things simple we only give either 50 or 25 pipes.
# The pipes then get to be used to spend on upgrades

@onready var upgrade_1 = $"UI/Upgrade 1"
@onready var upgrade_2 = $"UI/Upgrade 2"

@onready var win_sound = $Win
@onready var vine_boom = $VineBoom

@onready var strandbeest = $Strandbeest
@onready var player = $Player

var game_playing: bool = true
var round_started: bool = false
var round_start_time: float = 0.0

func _ready() -> void:
	upgrade_1.pressed.connect(GameData.buy_speed_upgrade)
	upgrade_2.pressed.connect(GameData.buy_momentum_upgrade)

func _process(delta: float) -> void:
	if game_playing == false and Input.is_action_just_pressed("restart"):
		restart_game()


func start_round() -> void:
	if round_started:
		return
	round_started = true
	round_start_time = Time.get_ticks_usec()


func game_over():
	game_playing = false
	vine_boom.play()

func win():
	win_sound.play()
	game_playing = false
	var elapsed_time = (Time.get_ticks_usec() - round_start_time) / 1000000.0
	print(elapsed_time)
	if elapsed_time <= 45.0:
		GameData.add_pipes(50)
	else:
		GameData.add_pipes(25)


func restart_game() -> void:
	for wind_charge in get_tree().get_nodes_in_group("Wind charge"):
		wind_charge.queue_free()
	strandbeest.reset_round()
	player.reset_round()
	round_start_time = 0.0
	game_playing = true
	round_started = false
