extends Area2D


var _is_held := false

onready var parent:Node = get_parent()


func _ready() -> void:
	connect("input_event",self,"_on_input_event")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		event = event as InputEventMouseMotion
		if _is_held:
			parent.global_position = event.global_position
			get_tree().set_input_as_handled()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		_is_held = event.pressed
		var mouse_mode: int = (Input.MOUSE_MODE_CONFINED
				if event.pressed
				else Input.MOUSE_MODE_VISIBLE)
		Input.mouse_mode = mouse_mode
