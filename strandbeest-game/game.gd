extends Node2D

# Notes:
# game.gd / the script attached to Node2D acts as a refree, it needs to know and processes what happened and reacted.

# Its job is to:
# - Know when a round starts
# - Know when a round ends - either from winning (strandbeest crosses line) OR losing (strandbeest tipping over).
# - Show end of a round message, varies from condition. (show game over and 0 pipes is gained when losing,
# and either 25 or 50 pipe is gained)

# The amount of pipes gained by a player varies with their winning time, the longer they took for the strandbeest to cross
# the line, the lower they get. But to keep things simple we only give either 50 or 25 pipes.
# The pipes then get to be used to spend on upgrades

var game_playing: bool = false
