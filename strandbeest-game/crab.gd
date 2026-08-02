extends CharacterBody2D


@onready var animation = $AnimatedSprite2D
@onready var play = get_node("/root/UI/Tutorial")

var loop_amount: float = 3.0

if 

func _ready():
	play_animation()

func play_animation():
	animation.animation_finished.connect(_on_animation_finished)
	animation.play("Crab Idle")

func _on_animation_finished():
	if animation.animation == "Crab Idle":
		animation.play()
