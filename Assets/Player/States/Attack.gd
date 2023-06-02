extends BaseState

# State nodes
@export_node_path("Node") var walk_node
@export_node_path("Node") var sprint_node
@export_node_path("Node") var block_node
@export_node_path("Node") var idle_node
@export_node_path("Node") var roll_node

@onready var walk_state: BaseState = get_node(walk_node)
@onready var sprint_state: BaseState = get_node(sprint_node)
@onready var block_state: BaseState = get_node(block_node)
@onready var idle_state: BaseState = get_node(idle_node)
@onready var roll_state: BaseState = get_node(roll_node)
