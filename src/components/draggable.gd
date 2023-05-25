class_name Draggable
extends Control
# Expects to be attached to an Area2D


var _is_mouse_inside := false
var _is_held := false
var _click_position: Vector2

onready var _parent = get_parent()


func _ready() -> void:
#	_parent.input_pickable = false
#	_parent.connect("mouse_entered", self, "_on_mouse_entered")
#	_parent.connect("mouse_exited", self, "_on_mouse_exited")
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")


func _process(_delta: float) -> void:
	# This is here instead of _unhandled_input so you can drag while panning
	if _is_held:
		owner.rect_position = owner.get_global_mouse_position() - _click_position


func _gui_input(event: InputEvent) -> void:
#	if _is_mouse_inside and event.is_action("select"):
	if event.is_action("select"):
#		print(_parent.paper_name)
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
			_parent.raise()


# TODO: How to put most recently moved paper on top?
#func _unhandled_input(event: InputEvent) -> void:
#	if _is_mouse_inside and event.is_action("select"):
#		event = event as InputEventMouseButton
#		# To keep mouse inside window when dragging
#		var mouse_mode: int = (Input.MOUSE_MODE_CONFINED
#				if event.pressed
#				else Input.MOUSE_MODE_VISIBLE)
#		Input.mouse_mode = mouse_mode
#		_is_held = event.pressed
#		if _is_held:
#			_click_position = owner.get_local_mouse_position()
#		else:
#			_parent.get_parent().move_child(_parent, _parent.get_parent().get_child_count() - 1)
#
#		get_tree().set_input_as_handled()


func _on_mouse_entered() -> void:
	_is_mouse_inside = true


func _on_mouse_exited() -> void:
	_is_mouse_inside = false
