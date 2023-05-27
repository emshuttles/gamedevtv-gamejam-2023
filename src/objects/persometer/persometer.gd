class_name Persometer
extends Control


export var use_max:int = 4
export var use_count:int = 0

var is_over_evaluation:bool = false
var last_entered_area:Area2D
var active_evaluation:Paper

var _target_x:int = 0 # Kind
var _target_y:int = 0 # Analytical

onready var node_animation_player:AnimationPlayer = $"%AnimationPlayer"
onready var button_activate := $"%ButtonActivate"
onready var axes:Dictionary = {
	"x": $"%AxisX",
	"y": $"%AxisY",
}
onready var uses:Array = $Uses.get_children()


func _ready() -> void:
	node_animation_player.assigned_animation = "close"
	Signals.connect("raised",self,"_on_raised")


func _on_ButtonActivate_pressed() -> void:
	if use_count < use_max and is_over_evaluation:
		var use = $Uses.get_child(use_count)
		use.power_down()
		use_count += 1
		node_animation_player.play("activate")

		axes.x.check(_target_x)
		axes.y.check(_target_y)


func _on_Area2D_area_entered(area: Area2D) -> void:
	if not (area.owner is Paper and area.owner.is_evaluation):
		return

	var evaluation: Paper = area.owner
	remove_highlight_from_paper()
	
	active_evaluation = evaluation
	# Add highlight
	evaluation.modulate = Color(1,1.1,1.1)
	
	
	_target_x = evaluation.kind
	_target_y = evaluation.analytical

	last_entered_area = area
	for i in uses.size():
		if use_count <= i:
			var use:Power = uses[i]
			use.power_up()
	is_over_evaluation = true
	_animate_axes()


func _on_Area2D_area_exited(area: Area2D) -> void:
	if area == last_entered_area:
		remove_highlight_from_paper()
		for use in uses:
			use.power_down()
		is_over_evaluation = false
	_animate_axes()


func remove_highlight_from_paper():
	if active_evaluation:
		active_evaluation.modulate = Color(1,1,1)


func _animate_axes() -> void:
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


func _on_raised():
	# NOTHING rises above me
	raise()
