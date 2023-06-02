class_name Player
extends CharacterBody2D

@export var camera_lerp_magnitude = 1000
@export var offset_normalize = 350


# Node References
@export_node_path("Node") var animations_node
@export_node_path("Node") var states_node
@export_node_path("Node") var stats_node

@onready var animations = get_node(animations_node)
@onready var states = get_node(states_node)
@onready var stats = get_node(stats_node)


var mouse_is_close = true
var mouse_lerp_size = Vector2.ZERO

signal updateState
signal updateHealth
signal updateStamina
signal updateNutrition

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states
	# that way they can move and react accordingly
	states.init_player(self)
	stats.init_player(self)
	#emit_signal("initStats", )
	mouse_is_close = false
	mouse_lerp_size = get_viewport().size

func _unhandled_input(event: InputEvent) -> void:
	states.input(event)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
	if (mouse_is_close == false):
		var mouse_offset = (get_viewport().get_mouse_position() - Vector2(mouse_lerp_size / 8))
		$Camera.position = lerp(Vector2(), mouse_offset.normalized() * offset_normalize, mouse_offset.length() / camera_lerp_magnitude)

func _process(delta: float) -> void:
	states.process(delta)

func _mouse_entered():
	mouse_is_close = true
	var mouse_offset = (get_viewport().get_mouse_position() - Vector2(mouse_lerp_size / 8))
	$Camera.position = lerp(Vector2(), Vector2.ZERO, mouse_offset.length() / camera_lerp_magnitude)

func _mouse_exited():
	mouse_is_close = false

func currentState(state):
	emit_signal("updateState", state)
