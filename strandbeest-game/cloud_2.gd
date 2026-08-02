extends Sprite2D

# All notes for cloud is on cloud_1.gd

@export var radius: float = 5.0
@export var cycle_seconds: float = 6.0
@export var phase_offset: float = 1.0

var _rest_position: Vector2
var _omega: float
var _t: float

func _ready() -> void:
	_t = phase_offset
	_omega = TAU / cycle_seconds
	_rest_position = position
	
func _process(delta: float) -> void:
	_t += delta
	position.x = _rest_position.x + radius * sin(_omega * _t)
	position.y = _rest_position.y + radius * cos(_omega * _t)
