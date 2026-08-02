extends Sprite2D

# Notes:
# Similar mechanics to the waves, each layer would have its own movement script so that it has the "fluffy" effect,
# this adds realism instead of just 1 static cloud design.
# But it would also have similar mechanicsto the wave_back.gd, the [_state]

@export var radius: float = 4.0
@export var cycle_seconds: float = 3.0
@export var phase_offset: float = 0.0

var _rest_position: Vector2
var _omega: float
var _t: float

func _ready() -> void:
	_t = phase_offset
	_omega = TAU / cycle_seconds
	# The [position] is the sprite's starting point and making it equal to [_rest_position] it would store both x and y values in vector form.
	_rest_position = position
	
func _process(delta: float) -> void:
	_t += delta
	# Since [_rest_position] is a vector, we want to only take the x or y value in the equation,
	# so we can add either [.x] or [.y] behind the [_rest_position].
	# This works similarly to [position.x] or [position.y] where the .x or .y would state which part of the coordinate we want.
	position.x = _rest_position.x + radius * sin(_omega * _t)
	position.y = _rest_position.y + radius * cos(_omega * _t)
