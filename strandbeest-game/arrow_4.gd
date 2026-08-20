extends CanvasItem

@export var fade_duration: float = 1.0

var _fade_state: String = "hidden"
var _fade_t: float = 0.0


func _ready() -> void:
	modulate.a = 0.0
	visible = false

func _process(delta: float) -> void:
	match _fade_state:
		"Fading in":
			_fade_t += delta
			_fade_t = clamp(_fade_t, 0.0, fade_duration)
			modulate.a = (1.0 - cos(PI * _fade_t / fade_duration)) / 2.0
			if _fade_t >= fade_duration:
				_fade_state = "Shown"
		"Fading out":
			_fade_t += delta
			_fade_t = clamp(_fade_t, 0.0, fade_duration)
			modulate.a = 1.0 - (1.0 - cos(PI * _fade_t / fade_duration)) / 2.0
			if _fade_t >= fade_duration:
				_fade_state = "Hidden"
				visible = false

func fade_in() -> void:
	visible = true
	_fade_state = "Fading in"
	_fade_t = 0.0


func fade_out() -> void:
	_fade_state = "Fading out"
	_fade_t = 0.0
