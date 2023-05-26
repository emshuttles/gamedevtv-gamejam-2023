extends Control


export var target_x:int = 3
export var target_y:int = 5
export var use_max:int = 4
export var use_count:int = 0

var is_over_evaluation:bool = false

onready var node_animation_player:AnimationPlayer = $"%AnimationPlayer"
onready var button_activate := $"%ButtonActivate"

onready var axes:Dictionary = {
	"x": $"%AxisX",
	"y": $"%AxisY",
	}

onready var uses:Array = $Uses.get_children()

func _ready() -> void:
	node_animation_player.assigned_animation = "close"


func _on_ButtonActivate_pressed() -> void:
	if use_count < use_max and is_over_evaluation:
		var use = $Uses.get_child(use_count)
		use.power_down()
#		use_highlight.visible = false
		use_count += 1
		node_animation_player.play("activate")

		axes.x.check(target_x)
		axes.y.check(target_y)


func _on_Area2D_area_entered(area: Area2D) -> void:
	for i in uses.size():
		if use_count <= i:
			var use:Power = uses[i]
			use.power_up()
	is_over_evaluation = true
#	button_activate.disabled = false
	print("collision with: ", area.name)



func _on_Area2D_area_exited(area: Area2D) -> void:
	for use in uses:
		use.power_down()
	is_over_evaluation = false
#	button_activate.disabled = true


func _on_Draggable_drag_ended() -> void:
	var assigned_animation = node_animation_player.assigned_animation
	if is_over_evaluation:
		if assigned_animation == "close":
			node_animation_player.play("open")
	else:
		if assigned_animation != "close":
			node_animation_player.play("close")
			for axis in axes.values():
				axis = axis as Axis
				axis.reset_warmth()
			
