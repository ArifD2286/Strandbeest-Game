extends CharacterBody2D


@onready var crab = $AnimatedSprite2D
@onready var tutorial = get_node("/root/Node2D/UI/Tutorial")
# Reminder: To get a variable from a different node, you first must use get_node 
# and then add the node's name, (node name.variable name)

func _ready() -> void:
	crab.visible = false
	crab.animation_finished.connect(_on_animation_finished)

func _process(delta: float) -> void:
	if tutorial.tutorial_playing == true and not crab.visible:
		crab.visible = true
		crab.play("Crab Spawn")

func _on_animation_finished():
	if crab.animation == "Crab Idle":
		crab.play("Crab Spawn")
	elif crab.animation == "Crab Idle":
		crab.play("Crab Idle")
