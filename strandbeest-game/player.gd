extends CharacterBody2D


var _state: String = "Idle"
var _t: float = 0.0
var reset_time: float = 2.0


func _process(delta: float) -> void:
	velocity.y = 0
	velocity.x = 0

	if _state == "Idle" and Input.is_action_just_pressed("shooting"):
		_state = "Charging"
	elif _state == "Charging" and Input.is_action_just_released("shooting"):
		_state = "Burst"
	if _state == "Burst":
		_t += delta
		if _t >= reset_time:
			_t = 0.0
			_state = "Idle"
