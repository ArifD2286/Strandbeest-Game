extends Button

# Notes:
# - To update the cost for upgrades on the button's text

func _process(delta: float) -> void:
	text = str(GameData.momentum_cost) + " Pipes"
