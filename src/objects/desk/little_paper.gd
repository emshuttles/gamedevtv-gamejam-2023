extends Area2D


var _is_held := false


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		event = event as InputEventMouseMotion
		if _is_held:
			global_position = event.global_position
			get_tree().set_input_as_handled()


# TODO: Need to keep paper on desk, not just in window
func _on_LittlePaper_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		_is_held = event.pressed
		var mouse_mode: int = (Input.MOUSE_MODE_CONFINED
				if event.pressed
				else Input.MOUSE_MODE_VISIBLE)
		Input.mouse_mode = mouse_mode
