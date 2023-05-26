class_name Draggable
extends Control


var _is_mouse_inside := false
var _is_held := false
var _click_position: Vector2

onready var _parent: CanvasItem = get_parent()


signal drag_ended()


func _process(_delta: float) -> void:
	# This is here instead of _unhandled_input so you can drag while panning
	if _is_held:
		owner.rect_position = owner.get_global_mouse_position() - _click_position


func _gui_input(event: InputEvent) -> void:
	if event.is_action("select"):
		event = event as InputEventMouseButton

		# To keep mouse inside window when dragging
		var mouse_mode: int = (Input.MOUSE_MODE_CONFINED
				if event.pressed
				else Input.MOUSE_MODE_VISIBLE)
		Input.mouse_mode = mouse_mode

		_parent.raise()
		_is_held = event.pressed
		if _is_held:
			_click_position = owner.get_local_mouse_position()
		else:
			emit_signal("drag_ended")
