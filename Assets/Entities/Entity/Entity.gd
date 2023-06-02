class_name Entity
extends CharacterBody2D

signal updateState
signal updateHealth
signal updateEnergy

@export_node_path("Node") var animations_node
@export_node_path("Node") var states_node
@export_node_path("Node") var stats_node

@onready var animations = get_node(animations_node)
@onready var states = get_node(states_node)
@onready var stats = get_node(stats_node)

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states
	# that way they can move and react accordingly
	states.init(self)
	stats.init(self)

func _unhandled_input(event: InputEvent) -> void:
	states.input(event)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)

func _process(delta: float) -> void:
	states.process(delta)

func currentState(state):
	emit_signal("updateState", state)
