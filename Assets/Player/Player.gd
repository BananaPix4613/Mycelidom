class_name Player
extends CharacterBody2D

@export var camera_lerp_magnitude = 1000
@export var offset_normalize = 350

#var velocity = Vector2.ZERO
var mouse_is_close = true
var mouse_lerp_size = Vector2.ZERO

@onready var animations = $AnimationPlayer
@onready var states = $State_Manager

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states
	# that way they can move and react accordingly
	states.init(self)
	mouse_is_close = false
	mouse_lerp_size = get_viewport().size

func _unhandled_input(event: InputEvent) -> void:
	states.input(event)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
	if (mouse_is_close == false):
		var mouse_offset = (get_viewport().get_mouse_position() - Vector2(mouse_lerp_size / 8))
		$Camera2D.position = lerp(Vector2(), mouse_offset.normalized() * offset_normalize, mouse_offset.length() / camera_lerp_magnitude)

func _process(delta: float) -> void:
	$Label.set_text(str(states.current_state))
	states.process(delta)

func _mouse_entered():
	mouse_is_close = true
	var mouse_offset = (get_viewport().get_mouse_position() - Vector2(mouse_lerp_size / 8))
	$Camera2D.position = lerp(Vector2(), Vector2.ZERO, mouse_offset.length() / camera_lerp_magnitude)

func _mouse_exited():
	mouse_is_close = false
