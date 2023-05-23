extends Area2D


var _is_mouse_inside := false
var _is_held := false
var _click_position: Vector2


func _unhandled_input(event: InputEvent) -> void:
	if _is_mouse_inside and event.is_action("select"):
		event = event as InputEventMouseButton
		_is_held = event.pressed
		var mouse_mode: int = (Input.MOUSE_MODE_CONFINED
				if event.pressed
				else Input.MOUSE_MODE_VISIBLE)
		Input.mouse_mode = mouse_mode
		_click_position = get_local_mouse_position()
		get_tree().set_input_as_handled()
	elif event is InputEventMouseMotion:
		event = event as InputEventMouseMotion
		if _is_held:
			global_position = event.position - _click_position
			get_tree().set_input_as_handled()


func _on_LittlePaper_mouse_entered() -> void:
	_is_mouse_inside = true


func _on_LittlePaper_mouse_exited() -> void:
	_is_mouse_inside = false
