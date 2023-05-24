extends MarginContainer


onready var animation_player:AnimationPlayer = $"%AnimationPlayer"


func _unhandled_input(event: InputEvent) -> void:
#	skip()
	pass


func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.is_pressed():
			skip()


func skip():
	var animation_last_second:float = animation_player.current_animation_length - 1
	animation_player.seek(animation_last_second)


func change_scene():
	Signals.emit_signal("scene_transition",Scenes.office)
	queue_free()
