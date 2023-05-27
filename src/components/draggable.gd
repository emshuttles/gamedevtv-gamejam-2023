class_name Draggable
extends Node


var _is_mouse_inside := false
var _is_held := false
var _click_position: Vector2

onready var _parent: CanvasItem = get_parent()


func _ready() -> void:
	_parent.connect("gui_input",self,"_gui_input")


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
		Signals.emit_signal("raised")

		_is_held = event.pressed
		if _is_held:
			_click_position = owner.get_local_mouse_position()
		else:
			_snap_to_tray()


func _snap_to_tray() -> void:
	if not (_parent is Paper and (_parent.is_evaluation or _parent.is_job_request)):
		return

	_parent = _parent as Paper
	var paper_area: Area2D = _parent.get_node("Area2D")
	var trays: Array = get_tree().get_nodes_in_group("tray")
	for tray in trays:
		tray = tray as Tray
		if tray.overlaps_area(paper_area):
			_parent.rect_position = tray.position # Top-left corner is in center of tray
			_parent.rect_position.x -= _parent.rect_size.x / 2
			_parent.rect_position.y -= _parent.rect_size.y / 2 # Actually centered in tray
