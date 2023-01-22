extends SubViewportContainer

@onready var player = $SubViewport/Scene/Player
@onready var mouse_detector = $MouseDetection

func _ready():
	mouse_detector.connect("mouse_entered",Callable(player,"_mouse_entered"))
	mouse_detector.connect("mouse_exited",Callable(player,"_mouse_exited"))
