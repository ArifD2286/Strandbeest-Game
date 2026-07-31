extends Sprite2D

# Major notes will be on [wave_back.gd]

@export var reach: float = 360.0
@export var cycle_seconds: float = 6.0
@export var phase_offset: float = 0.0

var _rest_x: float
var _omega: float
var _t: float

func _ready() -> void:
	_rest_x = position.x
	_omega = TAU / cycle_seconds
	_t = phase_offset

func _process(delta: float) -> void:
	_t += delta
	position.x = _rest_x + reach * sin(_omega * _t)
