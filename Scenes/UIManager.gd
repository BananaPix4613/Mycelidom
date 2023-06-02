extends SubViewportContainer


# Node References
@onready var player = $SubViewport/Scene/Player
@onready var mouse_detector = $MouseDetection
@onready var state_label = $DebugMenu/PanelContainer/MarginContainer/VBoxContainer/State
@onready var health_label = $DebugMenu/PanelContainer/MarginContainer/VBoxContainer/Health
@onready var stamina_label = $DebugMenu/PanelContainer/MarginContainer/VBoxContainer/Stamina
@onready var nutrition_label = $DebugMenu/PanelContainer/MarginContainer/VBoxContainer/Nutrition


func _ready():
	
	# Mouse detector signals
	mouse_detector.connect("mouse_entered", Callable(player, "_mouse_entered"))
	mouse_detector.connect("mouse_exited", Callable(player, "_mouse_exited"))
	
	# DEBUG label signals
	player.connect("updateState", Callable(self, "updateState"))
	player.connect("updateHealth", Callable(self, "updateHealth"))
	player.connect("updateStamina", Callable(self, "updateStamina"))
	player.connect("updateNutrition", Callable(self, "updateNutrition"))
	
	# DEBUG initializers
	#player.connect("initStats", Callable(self, "initStats"))

func updateState(state):
	state_label.text = state

func updateHealth(health):
	health_label.text = health

func updateStamina(stamina):
	stamina_label.text = stamina

func updateNutrition(nutrition):
	nutrition_label.text = nutrition

func initStats(health_max, stamina_max, nutrition_max):
	health_label.text = "Health: " + health_max + "/" + health_max
	stamina_label.text = "Stamina: " + stamina_max + "/" + stamina_max
	nutrition_label.text = "Nutrition: " + nutrition_max + "/" + nutrition_max
