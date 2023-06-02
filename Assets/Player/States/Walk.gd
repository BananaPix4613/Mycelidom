extends MoveState

func enter() -> void:
	super.enter()
	player.currentState("walk_state")
	player.animations.speed_scale = 1

func input(event: InputEvent) -> BaseState:
	# First run parent code and make sure we don't need to exit early
	# based checked its logic
	var new_state = super.input(event)
	if new_state:
		return new_state
	
	if Input.is_action_pressed("sprint"):
		return sprint_state
	return null
