class_name Draggable
extends Node


var _is_mouse_inside := false
var _is_held := false
var _click_position: Vector2

onready var _parent: Node = get_parent()


func _ready() -> void:
	_parent.connect("mouse_entered", self, "_on_mouse_entered")
	_parent.connect("mouse_exited", self, "_on_mouse_exited")


func _process(_delta: float) -> void:
	# This is here instead of _unhandled_input so you can drag while panning
	if _is_held:
		owner.global_position = owner.get_global_mouse_position() - _click_position


# TODO: How to put most recently moved paper on top?
func _unhandled_input(event: InputEvent) -> void:
	if _is_mouse_inside and event.is_action("select"):
		event = event as InputEventMouseButton
		_is_held = event.pressed

		# To keep mouse inside window when dragging
		var mouse_mode: int = (Input.MOUSE_MODE_CONFINED
				if event.pressed
				else Input.MOUSE_MODE_VISIBLE)
		Input.mouse_mode = mouse_mode

		_click_position = owner.get_local_mouse_position()
		get_tree().set_input_as_handled()


func _on_mouse_entered() -> void:
	_is_mouse_inside = true


func _on_mouse_exited() -> void:
	_is_mouse_inside = false
