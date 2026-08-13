extends Sprite2D

# This layer would have a different wave design compared to [Wave Back] node,
# it will have a short delay so that it appears after the [Wave Back]'s position decrease.
# This way we can make the waves look more realistic by showing that the water is dragged by the sand's surface

@export var reach: float = 320.0
@export var cycle_seconds: float = 8.0
@export var phase_offset: float = -0.1


# Stores the original x position
var _rest_x: float
# [_omega] turns "seconds elapsed" into "how far are we along the sine or cosine graph?"
var _omega: float
# [_t] a running clock that only counts seconds since the wave started
var _t: float

func _ready() -> void:
	_rest_x = position.x
	# [TAU] is godot's built in constant value which is equal to 2π
	_omega = TAU / cycle_seconds
	_t = phase_offset

func _process(delta: float) -> void:
	_t += delta
	position.x = _rest_x + reach * sin(_omega * _t)
