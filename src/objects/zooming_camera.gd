extends Camera2D


const CENTER_POSITION := Vector2(512, 300)

export var zoom_level := 0.25
export var zoom_duration := 0.2

var _is_zoomed := false

onready var tween: Tween = $Tween


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom"):
		event = event as InputEventMouseButton
		_zoom(event.global_position)


func _zoom(click_position: Vector2) -> void:
	_is_zoomed = not _is_zoomed
	var new_zoom_level: float = zoom_level if _is_zoomed else 1.0
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
	var new_position: Vector2 = zoom_position if _is_zoomed else CENTER_POSITION
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
