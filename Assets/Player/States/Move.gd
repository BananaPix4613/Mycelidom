class_name MoveState
extends BaseState

@export var move_speed = 120.0
@export_node_path(Node) var idle_node
@export_node_path(Node) var sprint_node
@export_node_path(Node) var walk_node
@export_node_path(Node) var block_node
@export_node_path(Node) var attack_node
@export_node_path(Node) var roll_node

@onready var idle_state: BaseState = get_node(idle_node)
@onready var sprint_state: BaseState = get_node(sprint_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var block_state: BaseState = get_node(block_node)
@onready var attack_state: BaseState = get_node(attack_node)
@onready var roll_state: BaseState = get_node(roll_node)

var directions = ["walk_right", "walk_right_diagonal_down", "walk_down", "walk_left_diagonal_down", "walk_left", "walk_left_diagonal_up", "walk_up", "walk_right_diagonal_up"]
var idle_directions = ["right", "right_diagonal_down", "down", "left_diagonal_down", "left", "left_diagonal_up", "up", "right_diagonal_up"]
var roll_directions = ["roll_right", "roll_right_diagonal_down", "roll_down", "roll_left_diagonal_down", "roll_left", "roll_left_diagonal_up", "roll_up", "roll_right_diagonal_up"]
var move = Vector2()
var facing = Vector2()
var is_rolling = false

func input(_event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("roll"):
		return roll_state
	
	return null

func physics_process(_delta: float) -> BaseState:
	move = get_movement_input()
	
	var animation = direction2str(facing)
	if player.animations.current_animation != animation:
		player.animations.play(animation)
	
	move = move.normalized()
	player.velocity.x = move.x * move_speed
	player.velocity.y = move.y * move_speed
	player.set_velocity(player.velocity)
	player.move_and_slide()
	player.velocity = player.velocity
	
	if move == Vector2.ZERO && is_rolling == false:
		return idle_state
	return null

func get_movement_input() -> Vector2:
	var left = Input.is_action_pressed("move_left")
	var right = Input.is_action_pressed("move_right")
	var up = Input.is_action_pressed("move_up")
	var down = Input.is_action_pressed("move_down")
	
	move.x = int(right) - int(left)
	move.y = int(down) - int(up)
	
	if left or right or up or down:
		facing = move
	
	return move

func direction2str(direction):
	var angle = direction.angle()
	if angle < 0:
		angle += 2 * PI
	var index = round(angle / PI * 4)
	if move.x == 0 and move.y == 0:
		return idle_directions[index]
	elif is_rolling:
		return idle_directions[index] #roll_directions[index]
	else:
		return directions[index]
