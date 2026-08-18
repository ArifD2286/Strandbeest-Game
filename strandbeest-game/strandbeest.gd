extends CharacterBody2D

# Notes:
# The way we want the strandbeest to behave is:
# - once it gets hit with the wind charge sent by player, it would get a speed boost before letting it decay
# overtime
# - we can change the [decay_rate] and [max_speed] for upgrade later.

@onready var animation = $AnimatedSprite2D
@onready var game = get_node("/root/Node2D")

@export var speed_boost: float = 50.0
var decay_rate: float
var max_speed: float

var current_speed: float = 0.0

func _ready() -> void:
	animation.play("Walk")
	add_to_group("Strandbeest")
	$Hitbox.area_entered.connect(_hitbox_area_entered)


func _hitbox_area_entered(area: Area2D)	-> void:
	if area.get_parent().is_in_group("Wind charge"):
		current_speed += speed_boost
	elif area.get_parent().is_in_group("Finish line"):
		game.win()

func _physics_process(delta: float) -> void:
	if not game.game_playing:
		return
	
	decay_rate = 50 - GameData.momentum_level * 10
	max_speed = GameData.speed_level * 50.0 + 75.0
	current_speed = clamp(current_speed - decay_rate * delta, 0.0, max_speed)

	animation.speed_scale = current_speed / 40.0

	position.y -= current_speed * delta
	if current_speed >= max_speed:
		game.game_over()
		print("YOU LOST")
		animation.play("Tip over")
