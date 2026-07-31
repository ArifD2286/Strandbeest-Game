extends Sprite2D

# Notes:
# Similar mechanics to the waves, each layer would have its own movement script so that it has the "fluffy" effect,
# this adds realism instead of just 1 static cloud design.
# But it would also have similar mechanicsto the wave_back.gd, the [_state]

@export var radius: float = 2.0
@export var cycle_seconds: float = 2.0
@export var phase_offset: float = 2.0

var _rest_position: Vector2
var _omega: float
var _t: float

func _ready() -> void:
	_t = phase_offset
	_omega = TAU / cycle_seconds
	
func _process(delta: float) -> void:
	_t += delta
	position.x = _rest_position + radius * sin(_omega * _t)
	position.y = _rest_position + radius * cos(_omega * _t)
