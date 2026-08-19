extends Label

@export var reach: float = 4.0
@export var cycle_seconds: float = 4.0
@export var phase_offset: float = 1.0

var _rest_x: float
var _omega: float
var _t: float

func _ready() -> void:
	_rest_x = position.y
	_omega = TAU / cycle_seconds
	_t = phase_offset

func _process(delta: float) -> void:
	_t += delta
	position.y = _rest_x + reach * sin(_omega * _t)
