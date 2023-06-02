extends MoveState

@export var roll_time = 0.4
@export var cooldown = 1;

# State nodes
@export_node_path("Node") var roll_cooldown_node

@onready var roll_cooldown: Timer = get_node(roll_cooldown_node)

var current_roll_time: float = 0
var roll_direction = Vector2()

func enter() -> void:
	super.enter()
	player.currentState("roll_state")
	roll_cooldown.wait_time = cooldown
	current_roll_time = roll_time
	roll_direction = int2direction(directions.find(player.animations.get_current_animation()) + 1)
	is_rolling = true

func exit() -> void:
	super.exit()
	roll_cooldown.start()
	is_rolling = false

# Override MoveState input() since we don't want to change states based checked player input
func input(_event: InputEvent) -> BaseState:
	return null

func get_movement_input() -> Vector2:
	if roll_direction:
		return roll_direction
	return Vector2.ZERO

# Track how long we've been dashing so we know when to exit
func process(delta: float) -> BaseState:
	current_roll_time -= delta
	
	if current_roll_time > 0:
		return null
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
		if Input.is_action_pressed("sprint"):
			return sprint_state
		return walk_state
	return idle_state

func int2direction(num):
	match num:
		1:
			return Vector2(1,0)
		2:
			return Vector2(1,1)
		3:
			return Vector2(0,1)
		4:
			return Vector2(-1,1)
		5:
			return Vector2(-1,0)
		6:
			return Vector2(-1,-1)
		7:
			return Vector2(0,-1)
		8:
			return Vector2(1,-1)
