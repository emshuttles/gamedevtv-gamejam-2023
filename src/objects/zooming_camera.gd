extends Camera2D


const CENTER_POSITION := Vector2(512, 300)

export var zoom_levels := [0.25, 0.5, 0.75, 1.0]
export var zoom_duration := 0.2

var _zoom_level_index := 3

onready var tween: Tween = $Tween


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		event = event as InputEventMouseButton
		_zoom_level_index = max(_zoom_level_index - 1, 0)
		var new_zoom_level: float = zoom_levels[_zoom_level_index]
		_zoom(new_zoom_level, event.global_position)
	elif event.is_action_pressed("zoom_out"):
		event = event as InputEventMouseButton
		_zoom_level_index = min(_zoom_level_index + 1, 3)
		var new_zoom_level: float = zoom_levels[_zoom_level_index]
		_zoom(new_zoom_level, event.global_position)


func _zoom(new_zoom_level: float, click_position: Vector2) -> void:
	tween.interpolate_property(
		self,
		"zoom",
		zoom,
		Vector2(new_zoom_level, new_zoom_level),
		zoom_duration,
		tween.TRANS_SINE,
		tween.EASE_OUT
	)
	var zoom_position: Vector2 = _calculate_zoom_position(click_position)
	var is_zoomed: bool = new_zoom_level < zoom_levels[3]
	var new_position: Vector2 = zoom_position if is_zoomed else CENTER_POSITION
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


# TODO: To stop seeing beyond the desk when zoomed in
func _calculate_zoom_position(click_position: Vector2) -> Vector2:
	return click_position
