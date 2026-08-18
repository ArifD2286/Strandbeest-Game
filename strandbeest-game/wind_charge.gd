extends CharacterBody2D

# Notes:
# For each wind charge that spawns after player release, after hitting the strandbeest it would give
# the strandbeest a temporary movement boost before despawning.

@onready var wind_charge_animation = $AnimatedSprite2D

@export var travel_speed: float = 200.0

func _ready() -> void:
	add_to_group("Wind charge")
	$Hitbox.area_entered.connect(_hitbox_area_entered)
	wind_charge_animation.animation_finished.connect(_on_animation_finished)

func _process(delta: float) -> void:
	position.y -= travel_speed * delta
	wind_charge_animation.play("default")

func _hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Strandbeest"):
		queue_free()

func _on_animation_finished():
	if wind_charge_animation.animation == "default":
		wind_charge_animation.play("default")
