class_name Power
extends Node2D


onready var animation_player = $AnimationPlayer


func power_down():
	if animation_player.assigned_animation == "PowerUp":
		$AnimationPlayer.play("PowerDown")

func power_up():
	if animation_player.assigned_animation == "PowerDown":
		$AnimationPlayer.play("PowerUp")
