extends Node

@export_node_path("Node") var starting_state

var current_state: BaseState

func change_state(new_state: BaseState) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

# Initialize the state machine by giving each state a reference to the objects
# owned by the parent that they should be able to take control of
# and set a default state
func init_player(player: Player) -> void:
	for child in get_children():
		child.player = player
	
	# Initialize with a default state of idle
	change_state(get_node(starting_state))

func init(entity: Entity) -> void:
	for child in get_children():
		child.entity = entity
	
	# Initialize with a default state of idle
	change_state(get_node(starting_state))

# Pass through functions for the Player to call,
# handling state changes as needed
func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state:
		change_state(new_state)

func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state:
		change_state(new_state)

func process(delta: float) -> void:
	var new_state = current_state.process(delta)
	if new_state:
		change_state(new_state)
