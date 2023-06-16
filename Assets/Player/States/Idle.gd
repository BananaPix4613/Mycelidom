extends BaseState


# Node References
@export_node_path("Node") var walk_node
@export_node_path("Node") var sprint_node
@export_node_path("Node") var block_node
@export_node_path("Node") var attack_node
@export_node_path("Node") var roll_node

@onready var walk_state: BaseState = get_node(walk_node)
@onready var sprint_state: BaseState = get_node(sprint_node)
@onready var block_state: BaseState = get_node(block_node)
@onready var attack_state: BaseState = get_node(attack_node)
@onready var roll_state: BaseState = get_node(roll_node)


func enter() -> void:
	super.enter()
	player.currentState("idle_state")
	player.velocity = Vector2.ZERO

func input(_event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_down"):
		if Input.is_action_pressed("sprint"):
			return sprint_state
		return walk_state
	return null

func physics_process(_delta: float) -> BaseState:
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector2.UP)
	player.move_and_slide()
	player.velocity = player.velocity
	return null
