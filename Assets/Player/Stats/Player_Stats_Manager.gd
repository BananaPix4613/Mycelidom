extends Node

@export_node_path(Node) var health_node
@export_node_path(Node) var stamina_node
@export_node_path(Node) var nutrition_node

@onready var health_stat: DefaultStat = get_node(health_node)
@onready var stamina_stat: DefaultStat = get_node(stamina_node)
@onready var nutrition_stat: DefaultStat = get_node(nutrition_node)

func update_stat(stat: DefaultStat, value: int) -> void:
	if stat == health_stat:
		health_stat.update(value)
	elif stat == stamina_stat:
		stamina_stat.update(value)
	elif stat == nutrition_stat:
		nutrition_stat.update(value)

func update_stat_max(stat: DefaultStat, value: int) -> void:
	if stat == health_stat:
		health_stat.update_max(value)
	elif stat == stamina_stat:
		stamina_stat.update_max(value)
	elif stat == nutrition_stat:
		nutrition_stat.update_max(value)

func init(player: Player) -> void:
	pass

func _process(delta: float) -> void:
	pass
