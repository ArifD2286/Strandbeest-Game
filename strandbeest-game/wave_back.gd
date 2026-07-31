extends Sprite2D

# Notes:
# We want the the waves to move back and forth,
# their positions would follow a sine graph whilst their speeds follows a cosine graph (see more on position and speed section).
# This layer will share the same mechanic as wave_back_2.gd, wave_middle.gd, and wave_front.gd
# 

# -- POSITION --
# The position would start at 0 or lets say the centre value of the range (the range of the position),
# then it would gradually reach the peak,
# position 1 or the peak/max of the range before gradually returning to position 0.

# -- SPEED --
# Since its a cosine graph, the value at the start would be 1 instead of 0,
# this means that the waves are already moving at full speed before gradually decelerating or the value goes back to 0.

# -- Relationship between the speed and position of the wave --
# The relationship between sine and cosine graph perfectly explains the movement behaviour of the wave,
# when the position is at the max/furthest,
# the speed reaches zero and proceeds to decrease into the negatives (going opposite direction) and so on.

# to animate the waves the simpler way, we can make multiple layers with different textures but with similar mechanics
# that way we can save time from animating every frame for the waves.

# This is for the range of the movement of the waves
@export var reach: float = 320.0
# Below is for the time each full cycle lasts
@export var cycle_seconds: float = 6.0
# Offset, we will use different value for other layers
@export var phase_offset: float = 0.0


var _rest_x: float
# [_omega] turns "seconds elapsed" into "how far are we along the sine or cosine graph?"
var _omega: float
# [_t] a running clock that only counts seconds since the wave started
var _t: float

func _ready() -> void:
	# States the starting position
	_rest_x = position.x
	# [TAU] is godot's built in constant value which is equal to 2π
	_omega = TAU / cycle_seconds
	_t = phase_offset

func _process(delta: float) -> void:
	_t += delta
	# Code below is the math equation for the movement/change of the sprite's x coordinate
	position.x = _rest_x + reach * sin(_omega * _t)
