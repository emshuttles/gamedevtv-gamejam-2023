extends Node2D


export var target_x:int = 3
export var target_y:int = 5
export var use_max:int = 4

var use_count:int = 0
var is_over_candidate:bool = false

onready var node_animation_player:AnimationPlayer = $"%AnimationPlayer"


func _ready() -> void:
	node_animation_player.assigned_animation = "close"


func _on_ButtonActivate_pressed() -> void:
	if use_count < use_max:
		var use_highlight = $Uses.get_child(use_count)
		use_highlight.visible = false
		use_count += 1
		
		$AxisX.check(target_x)
		$AxisY.check(target_y)
		
	else:
		print("out of uses!")


func _on_Area2D_area_entered(area: Area2D) -> void:
	is_over_candidate = true
	print("collision with: ", area.name)



func _on_Area2D_area_exited(area: Area2D) -> void:
	is_over_candidate = false
	pass # Replace with function body.


func _on_Draggable_drag_ended() -> void:
	var assigned_animation = node_animation_player.assigned_animation
	if is_over_candidate:
		if assigned_animation != "open":
			node_animation_player.play("open")
	else:
		if assigned_animation != "close":
			node_animation_player.play("close")
