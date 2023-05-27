extends MarginContainer


var has_skipped:bool = false

onready var animation_player:AnimationPlayer = $"%AnimationPlayer"
onready var game: Node = get_parent()
onready var label: Label = $CenterContainer/LabelDay


func _ready() -> void:
	game.day += 1
	label.text = str("Day ", game.day)


func _unhandled_input(event: InputEvent) -> void:
	skip()


func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.is_pressed():
			skip()


func skip():
	if not has_skipped:
		has_skipped = true
		var animation_last_second:float = animation_player.current_animation_length - 1
		animation_player.seek(animation_last_second)


# Called from AnimationPlayer
func change_scene():
	var day: int = game.day
	var next_scene: PackedScene
	match day:
		1:
			next_scene = Scenes.office_1
		2:
			next_scene = Scenes.office_2
		3:
			next_scene = Scenes.office_3
		4:
			# Ending
			pass

	Signals.emit_signal("scene_transition", next_scene)
	queue_free()
