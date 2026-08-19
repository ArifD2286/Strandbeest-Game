extends Sprite2D

# Notes:
# To make the waves appear more realistic, this node will first move similarly like other nodes,
# but after reaching the max of the range, it would slowly disappear/lose visibility over time.
# This would be the water going into sand effect

@onready var waves = $"Ocean waves"

@export var reach: float = 340.0
@export var cycle_seconds: float = 8.0
@export var phase_offset: float = -0.1
@export var fade_seconds: float = 1.5

var _rest_x: float
var _omega: float
var _t: float
var _state: String = "Entering"
var _wait_time: float

func _ready() -> void:
	_rest_x = position.x
	_omega = TAU / cycle_seconds
	_t = phase_offset
	_wait_time = cycle_seconds - (cycle_seconds / 4.0) - fade_seconds


func _process(delta: float) -> void:
	match _state:
		"Entering":
			# 2 lines below are the same mechanics as for wave_front.gd, wave_middle.gd, etc.
			_t += delta
			position.x = _rest_x + reach * sin(_omega * _t)
			# Here is where the "fading" part comes in
			if _t >= cycle_seconds / 4.0:
				position.x = _rest_x + reach
				_t -= cycle_seconds / 4.0
				_state = "Fading"
		"Fading":
			_t += delta
			# Code below is the "fading" effect,
			modulate.a = clamp(1.0 - _t / fade_seconds, 0.0, 0.2)
			if _t >= fade_seconds:
				position.x = _rest_x
				modulate.a = 0.2
				_t -= fade_seconds
				_state = "Waiting"
		"Waiting":
			_t += delta
			if _t >= _wait_time:
				_t -= _wait_time
				_state = "Entering"
				waves.play()
