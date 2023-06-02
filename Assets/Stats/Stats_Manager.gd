extends Node

@export var Nodepaths: Array[NodePath]
var node_list: Array[Node]

var player: Player
var entity: Entity

func _ready():
	node_list.assign(Nodepaths.map(func(path): return get_node(path)))

# In the case the parent is a player, Initialize the stat manager by giving it
# a reference to the player
func init_player(managed: Player) -> void:
	player = managed

# In the case the parent is an entity, Initialize the stat manager by giving it
# a reference to the entity
func init(managed: Entity) -> void:
	entity = managed

func update_stat(stat: DefaultStat, value: int) -> void:
	if (node_list.find(stat)):
		if (node_list[stat].max_value <= value):
			if (value > 0):
				node_list[stat].current_value = value
			else:
				node_list[stat].current_value = 0
	else:
		printerr("stat could not be updated: " + str(stat))

func update_stat_max(stat: DefaultStat, value: int) -> void:
	if (node_list.find(stat)):
		if (value > 0):
			node_list[stat].current_value = value
		else:
			node_list[stat].current_value = 1
	else:
		printerr("stat max could not be updated: " + str(stat))

func process(_delta: float) -> void:
	pass
