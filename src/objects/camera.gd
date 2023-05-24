extends Camera2D


const CENTER_POSITION := Vector2(960, 540)
const DESK_WIDTH := 7680.0
const DESK_HEIGHT := 4320.0
const WINDOW_WIDTH := 1920.0
const WINDOW_HEIGHT := 1080.0

#var zoom_levels := [1.0, 2.0, 3.0, 4.0]
var zoom_levels := [1.0, 4.0]
var zoom_duration := 0.2
var pan_speed := 30.0

var _zoom_level_index := zoom_levels.size() - 1

onready var tween: Tween = $Tween


func _ready() -> void:
	var zoom_level: float = zoom_levels[_zoom_level_index]
	zoom = Vector2(zoom_level, zoom_level)


func _process(_delta: float) -> void:
	# Can't pan when zoomed out
	if _zoom_level_index == 3:
		return

	var direction := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	if direction.length() == 0:
		return

	if direction.length() > 1.0:
		direction = direction.normalized()

	var zoom_level: float = zoom_levels[_zoom_level_index]
	var new_position: Vector2 = global_position + direction * pan_speed * zoom_level
	var clamped_position: Vector2 = _keep_position_in_bounds(new_position)
	global_position = clamped_position


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		event = event as InputEventMouseButton
		if _zoom_level_index - 1 < 0:
			return
		var old_zoom_level: float = zoom_levels[_zoom_level_index]
		_zoom_level_index -= 1
		var new_zoom_level: float = zoom_levels[_zoom_level_index]
		_zoom(old_zoom_level, new_zoom_level, event.position)
	elif event.is_action_pressed("zoom_out"):
		event = event as InputEventMouseButton
		if _zoom_level_index + 1 >= zoom_levels.size():
			return
		var old_zoom_level: float = zoom_levels[_zoom_level_index]
		_zoom_level_index += 1
		var new_zoom_level: float = zoom_levels[_zoom_level_index]
		_zoom(old_zoom_level, new_zoom_level, event.position)


func _keep_position_in_bounds(new_position: Vector2) -> Vector2:
	var zoom_level: float = zoom_levels[_zoom_level_index]
	var minimum_x: float = -1 * (DESK_WIDTH - WINDOW_WIDTH * zoom_level) / 2 + CENTER_POSITION.x
	var maximum_x: float = (DESK_WIDTH - WINDOW_WIDTH * zoom_level) / 2 + CENTER_POSITION.x
	var minimum_y: float = -1 * (DESK_HEIGHT - WINDOW_HEIGHT * zoom_level) / 2 + CENTER_POSITION.y
	var maximum_y: float = (DESK_HEIGHT - WINDOW_HEIGHT * zoom_level) / 2 + CENTER_POSITION.y
	var clamped_x: float = clamp(new_position.x, minimum_x, maximum_x)
	var clamped_y: float = clamp(new_position.y, minimum_y, maximum_y)
	return Vector2(clamped_x, clamped_y)


func _zoom(old_zoom_level: float, new_zoom_level: float, mouse_position: Vector2) -> void:
	tween.interpolate_property(
		self,
		"zoom",
		zoom,
		Vector2(new_zoom_level, new_zoom_level),
		zoom_duration,
		tween.TRANS_SINE,
		tween.EASE_OUT
	)
	var viewport_size: Vector2 = get_viewport().size
	# From https://godotengine.org/qa/25983/camera2d-zoom-position-towards-the-mouse
	var position_difference: Vector2 = (((viewport_size / 2) - mouse_position)
			* (new_zoom_level - old_zoom_level))
	var new_position = _keep_position_in_bounds(global_position + position_difference)
	var is_zoomed_out: bool = new_zoom_level == zoom_levels[zoom_levels.size() - 1]
	if is_zoomed_out:
		new_position = CENTER_POSITION

	tween.interpolate_property(
		self,
		"global_position",
		global_position,
		new_position,
		zoom_duration,
		tween.TRANS_SINE,
		tween.EASE_OUT
	)
	tween.start()
