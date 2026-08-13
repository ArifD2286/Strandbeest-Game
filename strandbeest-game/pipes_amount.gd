extends Label


func _process(delta: float) -> void:
	update_text()

func update_text() -> void:
	# we cannot use [ "pipes" + String(GameData.pipes) ] as
	# the string() doest take an int (pipes var from game data is an int) directly
	# so we need to use str() instead
	text = "Pipes: " + str(GameData.pipes)
