extends Sprite2D

# Notes:
# We can use states again to have variation of animation for different scenarios.

# pull_fraction in player.gd is a var with a smooth change from 0 to 1,
# we can use this for the shift of position of the cloud.
# Say that 0 is when the cloud sits at its resting pos and 1 is where the cloud sits at its target spot.

# For the movement of the clouds, we can use a [.lerp()] (lerp is short for linear interpolation).
# It is an operation for Vector2 for blending in between two points using a "0 to 1".

# Vector2.ZERO is the target point for cloud1/2/3.gd to go to from their own initial position
# as [position] are local coordinates for the Player (CharacterBody2D) node.

@export var charge_target: Vector2 = Vector2.ZERO
@onready var player = get_parent()

@export var radius: float = 10.0
@export var burst_radius: float = 20.0

# The variables below doesn't make the duration for the animation state,
# it is only for the speed of the circle movement / how long it takes for 1 whole loop.

# For the duration of burst state (since its the only independent animation,
# whereas idle and charging relies on the player),
# it is declared in player.gd

@export var cycle_seconds: float = 5.0
@export var burst_seconds: float = 3.0
@export var phase_offset: float = 0.0

var _rest_position: Vector2
var _omega: float
var _t: float

func _ready() -> void:
	_t = phase_offset
	# The [position] is the sprite's starting point and making it equal to [_rest_position]
	# it would store both x and y values in vector form.
	_rest_position = position


func _process(delta: float) -> void:
	match player._state:
		"Idle":
			_t += delta
			_omega = TAU / cycle_seconds
			position.x = _rest_position.x + radius * sin(_omega * _t)
			position.y = _rest_position.y + radius * cos(_omega * _t)
		"Charging":
			_t += delta
			position = _rest_position.lerp(charge_target, player.pull_fraction)
		"Burst":
			_t += delta
			position.x = _rest_position.x + burst_radius * sin(_omega * _t)
			position.y = _rest_position.y + burst_radius * cos(_omega * _t)
