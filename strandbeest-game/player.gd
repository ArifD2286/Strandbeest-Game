extends CharacterBody2D

@export var burst_duration: float = 4

var _state: String = "Idle"
var _t: float = 0.0
var reset_time: float


func _ready() -> void:
	_t = burst_duration
	reset_time = 2


func _process(delta: float) -> void:
	velocity.y = 0
	velocity.x = 0
	_t += delta
	if _state == "Idle" and Input.is_action_just_pressed("shooting"):
		_state = "Charging"
	elif _state == "Charging" and Input.is_action_just_released("shooting"):
		_state = "Burst"
		if _t >= reset_time:
			_state = "Idle"
