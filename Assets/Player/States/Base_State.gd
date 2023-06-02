class_name BaseState
extends Node

# Pass in a reference to the player's kinematic body so that it can be only used by the state
var player: Player
var entity: Entity

# To be executed on state enter
func enter() -> void:
	pass

# To be executed on state exit
func exit() -> void:
	pass

# Enums are internally stored as ints, so that is the expected return type
# In the event of an input event use this input function
func input(_event: InputEvent) -> BaseState:
	return null

# For when you want something to happen while the state is active
func process(_delta: float) -> BaseState:
	return null

# See above but this one has physics (so cool)
func physics_process(_delta: float) -> BaseState:
	return null
