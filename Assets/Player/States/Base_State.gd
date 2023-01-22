class_name BaseState
extends Node

# Pass in a reference to the player's kinematic body so that it can be only used by the state
var player: Player

func enter() -> void:
	pass

func exit() -> void:
	pass

# Enums are internally stored as ints, so that is the expected return type
func input(_event: InputEvent) -> BaseState:
	return null

func process(_delta: float) -> BaseState:
	return null

func physics_process(_delta: float) -> BaseState:
	return null
