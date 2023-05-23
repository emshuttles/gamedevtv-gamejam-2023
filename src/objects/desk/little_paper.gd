extends Area2D


var _is_held := false


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		event = event as InputEventMouseMotion
		if _is_held:
			global_position = event.global_position
			get_tree().set_input_as_handled()


func _on_LittlePaper_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		_is_held = event.pressed
