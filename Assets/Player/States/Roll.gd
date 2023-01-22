extends MoveState

@export var dash_time = 0.4

var current_dash_time: float = 0
var dash_direction = Vector2.ZERO

func enter() -> void:
	super.enter()
	
	current_dash_time = dash_time
	
	dash_direction = facing

# Override MoveState input() since we don't want to change states based checked player input
func input(_event: InputEvent) -> BaseState:
	return null

func get_movement_input() -> Vector2:
	return dash_direction

# Track how long we've been dashing so we know when to exit
func process(delta: float) -> BaseState:
	current_dash_time -= delta
	
	if current_dash_time > 0:
		return null
	
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_down"):
		if Input.is_action_pressed("sprint"):
			return sprint_state
		return walk_state
	return idle_state
