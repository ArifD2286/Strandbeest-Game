extends Button

# Notes:
# - To update the cost for upgrades on the button's text

func _ready() -> void:
	GameData.get_speed_upgrade_cost()
	GameData.get_momentum_upgrade_cost()

func _process(delta: float) -> void:
	text = str(GameData.momentum_cost) + " Pipes"
