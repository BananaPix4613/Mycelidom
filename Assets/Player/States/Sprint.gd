extends MoveState

func enter() -> void:
	super.enter()
	
	player.animations.playback_speed = 2

func exit() -> void:
	super.exit()
	
	player.animations.playback_speed = 1

# Override MoveState input() since we don't want to change states based checked player input
func input(event: InputEvent) -> BaseState:
	# First run parent code and make sure we don't need to exit early
	# based checked its logic
	var new_state = super.input(event)
	if new_state:
		return new_state
	
	if Input.is_action_just_released("sprint"):
		return walk_state
	return null
