extends Node

# Notes:
# This script has autoload enabled so that everytime the game is resetted, it would have specific data stored.
# We need to keep the amount of pipes (in-game currency) the player has and
# the upgrade level for both upgrades (speed tolerance and momentum duration)

# Upgrade system cost:
# 1st upgrade would cost 50 pipes, 2nd updrade would cost 100 pipes, 3rd upgrade would cost 150 pipes - this upgrade cost
# applies for both the speed tolerance and momentum duration



var pipes: int = 0
var speed_level: int = 0
var momentum_level: int = 0
var speed_cost: int
var momentum_cost: int

	

func get_speed_upgrade_cost() -> int:
	speed_cost = (speed_level) * 50 + 50
	return speed_cost


func get_momentum_upgrade_cost() -> int:
	momentum_cost = (momentum_level) * 50 + 50
	return momentum_cost

# Purchasing an upgrade mechanic
# Checks if the player has sufficient amount of the currency (pipes) to purchase an upgrade first,
# same mechanic applies for both speed and momentum
# If the player purchased an upgrade,

func buy_speed_upgrade() -> void:
	get_speed_upgrade_cost()
	if pipes >= speed_cost:
		speed_level = speed_level + 1
		pipes = pipes - speed_cost
	pass


func buy_momentum_upgrade() -> void:
	get_momentum_upgrade_cost()
	if pipes >= momentum_cost:
		momentum_level = momentum_level + 1
		pipes = pipes - momentum_cost
	pass


func add_pipes(amount: int) -> void:
	pipes = pipes + amount
	pass
