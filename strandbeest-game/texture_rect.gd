extends TextureRect

@onready var button = get_node("/root/Node2D/UI/Button")
@onready var click = get_node("/root/Node2D/UI/Tutorial/Click")
@onready var crab = $AnimatedSprite2D

var button_was_clicked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = true
	button.visible = true
	crab.visible = true
	button.pressed.connect(button_clicked)
	button_was_clicked = false


func button_clicked() -> void:
	click.play()
	visible = false
	button.visible = false
	crab.visible = false
	button_was_clicked = true
