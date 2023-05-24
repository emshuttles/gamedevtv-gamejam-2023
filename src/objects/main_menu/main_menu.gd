extends Control

onready var animation_player = $"%AnimationPlayer"

func _on_ButtonWork_pressed() -> void:
	animation_player.play("fade_out")


func _on_ButtonQuit_pressed() -> void:
	get_tree().quit()


func change_scene():
	Signals.emit_signal("scene_transition",Scenes.day_x)
