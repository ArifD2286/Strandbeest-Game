extends Button

# Notes:
# - To update the cost for upgrades on the button's text

func _process(_delta: float) -> void:
	GameData.get_speed_upgrade_cost()
	text = str(GameData.speed_cost) + " Pipes"
	if GameData.speed_level >= GameData.max_speed_level:
		text = "MAX"
