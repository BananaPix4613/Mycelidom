extends DefaultStat

@export var max_value = 10
var current_value = 10

func update(new_value: int) -> void:
	if new_value <= max_value:
		current_value = new_value

func update_max(new_max: int) -> void:
	max_value = new_max
