extends CharacterBody2D

const WindCharge = preload("res://wind_charge.tscn")

@onready var tutorial = get_node("/root/Node2D/UI/Tutorial")
@export var charge_duration: float = 0.5

var pull_fraction: float = 0.0
var burst_fraction: float = 0.0
var _charge_t: float = 0.0
var _state: String = "Idle"
var _t: float = 0.0
var reset_time: float = 1.0


func _process(delta: float) -> void:
	velocity.y = 0
	velocity.x = 0

# If the player presses onto their space button, the state would go into the charging state
	if _state == "Idle" and Input.is_action_just_pressed("shooting") and not tutorial.tutorial_playing == true:
		_state = "Charging"
		_charge_t = 0.0

# If they release their space button, it goes into the bursting/shooting wind state.
# This state will be referred by cloud_1/2/3.gd for their animation/behaviour
	elif _state == "Charging" and Input.is_action_just_released("shooting") and not tutorial.tutorial_playing == true:
		var wind_charge = WindCharge.instantiate()
		wind_charge.global_position = global_position
		get_tree().current_scene.add_child(wind_charge)
		_state = "Burst"
		_t = 0.0

# We also want to put a condition where the player presses DURING the "Burst" state
	elif _state == "Burst" and Input.is_action_just_pressed("shooting") and not tutorial.tutorial_playing == true:
		_state = "Charging"
		_charge_t = 0.0

	if _state == "Charging":
		_charge_t += delta
		_charge_t = clamp(_charge_t, 0.0, charge_duration)
		pull_fraction = (1.0 - cos(PI * _charge_t / charge_duration)) / 2.0

	if _state == "Burst":
		_t += delta
		_t = clamp(_t, 0.0, reset_time)
		burst_fraction = (1.0 - cos(PI * _t / reset_time)) / 2.0
		if _t >= reset_time:
			_t = 0.0
			_state = "Idle"
