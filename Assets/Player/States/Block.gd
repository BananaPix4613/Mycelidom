extends BaseState

# State nodes
@export_node_path("Node") var walk_node
@export_node_path("Node") var sprint_node
@export_node_path("Node") var idle_node
@export_node_path("Node") var attack_node
@export_node_path("Node") var roll_node

@onready var walk_state: BaseState = get_node(walk_node)
@onready var sprint_state: BaseState = get_node(sprint_node)
@onready var idle_state: BaseState = get_node(idle_node)
@onready var attack_state: BaseState = get_node(attack_node)
@onready var roll_state: BaseState = get_node(roll_node)

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

#func _draw():
#	var center = Vector2(0, 1)
#	var radius = 10
#	var angle_from = 75
#	var angle_to = 195
#	var color = Color(1, 1, 1)
#	draw_circle_arc(center, radius, angle_from, angle_to, color)

#func draw_circle_arc(center, radius, angle_from, angle_to, color):
#	var nb_points = 12
#	var points_arc = PackedVector2Array()
#
#	for i in range(nb_points + 1):
#		var angle_point = deg_to_rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
#		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
#
#	for index_point in range(nb_points):
#		player.draw_line(points_arc[index_point], points_arc[index_point + 1], color, 2)
