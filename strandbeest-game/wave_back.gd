extends Sprite2D

# Notes:
# We want the the waves to move back and forth,
# their positions would follow a sine graph whilst their speeds follows a cosine graph.

# POSITION
# The position would start at 0 or lets say the edge of the left side of the screen,
# then it would gradually reach the peak,
# position 1 or the peak/max of the range before gradually returning to position 0.

# SPEED
# Since its a cosine graph, the value at the start would be 1 instead of 0,
# this means that the waves are already moving at full speed before gradually decelerating or the value goes back to 0.
# And also since the values of  cosine is offset ... sine graph would be 

# to animate the waves the simpler way, we can make multiple layers with different textures with similar mechanics
# that way we can save time from animating every fram for the waves

# This is for the range of the movement of the waves
@export var reach: float = 120.0
# Below is for the time each full cycle lasts
@export var cycle_seconds: float = 4.0
# Offset, we will use different value for other layers
@export var phase_offset: float = 0.0


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
