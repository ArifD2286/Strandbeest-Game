extends Button

# Notes:
# - To update the cost for upgrades on the button's text

func _process(delta: float) -> void:
	GameData.get_momentum_upgrade_cost()
	text = str(GameData.momentum_cost) + " Pipes"
