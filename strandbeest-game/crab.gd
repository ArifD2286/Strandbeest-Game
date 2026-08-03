extends CharacterBody2D


@onready var animation = $AnimatedSprite2D
@onready var tutorial = get_node("/root/Node2D/UI/Tutorial")

var loop_amount: float = 3.0

func _process(delta: float) -> void:
	# Reminder: To get a variable from a different node, you first must use get_node 
	# and then add the node's name, (node name.variable name)
	if tutorial.tutorial_playing == true:
		play_animation()


func play_animation():
	animation.animation_finished.connect(_on_animation_finished)
	animation.play("Crab Idle")

func _on_animation_finished():
	if animation.animation == "Crab Idle":
		animation.play()
