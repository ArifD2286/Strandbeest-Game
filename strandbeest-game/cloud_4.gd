extends Sprite2D

# All notes are on cloud_1.gd

@export var charge_target: Vector2 = Vector2.ZERO
@onready var player = get_parent()

@export var radius: float = 5.0
@export var charge_radius: float = 1.0
@export var burst_radius: float = 10.0

@export var cycle_seconds: float = 4.0

@export var settle_duration: float = 0.5

@export var phase_offset: float = 5.0

var _rest_position: Vector2
var _omega: float
var _t: float

var _settle_t: float = 0.0
var _prev_state: String = "Idle"

func _ready() -> void:
	_t = phase_offset
	_rest_position = position


func _process(delta: float) -> void:
	if player._state == "Idle" and _prev_state != "Idle":
		_settle_t = 0.0
	match player._state:
		"Idle":
			_t += delta
			_omega = TAU / cycle_seconds
			_settle_t += delta
			_settle_t = clamp(_settle_t, 0.0, settle_duration)
			var settle_fraction = (1.0 - cos(PI * _settle_t / settle_duration)) / 2.0
			var current_radius = lerp(burst_radius, radius, settle_fraction)
			position.x = _rest_position.x + current_radius * sin(_omega * _t)
			position.y = _rest_position.y + current_radius * cos(_omega * _t)
		"Charging":
			_t += delta
			_omega = TAU / cycle_seconds
			var current_centre = _rest_position.lerp(charge_target, player.pull_fraction)
			var current_radius = lerp(radius, charge_radius, player.pull_fraction)
			position.x = current_centre.x + current_radius * sin(_omega * _t)
			position.y = current_centre.y + current_radius * cos(_omega * _t)
		"Burst":
			_t += delta
			_omega = TAU / cycle_seconds
			var current_centre = charge_target.lerp(_rest_position, player.burst_fraction)
			var current_radius = lerp(charge_radius, burst_radius, player.burst_fraction)
			position.x = current_centre.x + current_radius * sin(_omega * _t)
			position.y = current_centre.y + current_radius * cos(_omega * _t)
	_prev_state = player._state
