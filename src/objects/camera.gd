extends Camera2D


const CENTER_POSITION := Vector2(960, 540)
const DESK_WIDTH := 7680.0
const DESK_HEIGHT := 4320.0
const WINDOW_WIDTH := 1920.0
const WINDOW_HEIGHT := 1080.0

export var zoom_levels := [1.0, 2.0, 3.0, 4.0]
export var zoom_duration := 0.2
export var pan_speed := 100.0

var _zoom_level_index := 3

onready var tween: Tween = $Tween


func _process(_delta: float) -> void:
	# Can't pan when zoomed out
	if _zoom_level_index == 3:
		return

	var direction := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	if direction.length() > 1.0:
		direction = direction.normalized()

	var new_position: Vector2 = _calculate_new_position(direction)
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


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		event = event as InputEventMouseButton
		_zoom_level_index = int(max(_zoom_level_index - 1, 0))
		var new_zoom_level: float = zoom_levels[_zoom_level_index]
		_zoom(new_zoom_level)
	elif event.is_action_pressed("zoom_out"):
		event = event as InputEventMouseButton
		_zoom_level_index = int(min(_zoom_level_index + 1, 3))
		var new_zoom_level: float = zoom_levels[_zoom_level_index]
		_zoom(new_zoom_level)


func _zoom(new_zoom_level: float) -> void:
	tween.interpolate_property(
		self,
		"zoom",
		zoom,
		Vector2(new_zoom_level, new_zoom_level),
		zoom_duration,
		tween.TRANS_SINE,
		tween.EASE_OUT
	)
	var is_zoomed_out: bool = new_zoom_level == zoom_levels[3]
	if is_zoomed_out:
		tween.interpolate_property(
			self,
			"global_position",
			global_position,
			CENTER_POSITION,
			zoom_duration,
			tween.TRANS_SINE,
			tween.EASE_OUT
		)

	tween.start()


func _calculate_new_position(direction: Vector2) -> Vector2:
	var zoom_level: float = zoom_levels[_zoom_level_index]
	var new_position: Vector2 = global_position + direction * pan_speed * zoom_level
	var minimum_x: float = -1 * (DESK_WIDTH - WINDOW_WIDTH * zoom_level) / 2 + CENTER_POSITION.x
	var maximum_x: float = (DESK_WIDTH - WINDOW_WIDTH * zoom_level) / 2 + CENTER_POSITION.x
	var minimum_y: float = -1 * (DESK_HEIGHT - WINDOW_HEIGHT * zoom_level) / 2 + CENTER_POSITION.y
	var maximum_y: float = (DESK_HEIGHT - WINDOW_HEIGHT * zoom_level) / 2 + CENTER_POSITION.y
	new_position.x = clamp(new_position.x, minimum_x, maximum_x)
	new_position.y = clamp(new_position.y, minimum_y, maximum_y)
	return new_position
