class_name Persometer
extends Control


const PERSOMETER_ARMS: Resource = preload("res://assets/audio/sfx/persometer_arms.wav")
const PERSOMETER_BUTTON: Resource = preload("res://assets/audio/sfx/persometer_button.wav")

export var use_max:int = 4
export var use_count:int = 0

var is_over_evaluation:bool = false
var last_entered_area:Area2D
var active_evaluation:Paper

var _target_x:int = 0 # Kind
var _target_y:int = 0 # Analytical
var _areas_below := [] # of Area2D

onready var node_animation_player:AnimationPlayer = $"%AnimationPlayer"
onready var button_activate := $"%ButtonActivate"
onready var axes:Dictionary = {
	"x": $"%AxisX",
	"y": $"%AxisY",
}
onready var uses:Array = $Uses.get_children()
onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer


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

		audio_player.stream = PERSOMETER_BUTTON
		audio_player.play()


func _on_Area2D_area_entered(area: Area2D) -> void:
	if not (area.owner is Paper and area.owner.is_evaluation):
		return

	if not _areas_below.has(area):
		_areas_below.append(area)

	# If you enter another Paper's area, but it's beneath the Paper you're currently selecting,
	# ignore it.
	if last_entered_area != null and last_entered_area.owner.is_greater_than(area.owner):
		return

	_select_evaluation(area)


func _select_evaluation(area: Area2D) -> void:
	var evaluation: Paper = area.owner
	_remove_highlight_from_paper()

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
	_areas_below.erase(area)
	if area == last_entered_area:
		_deselect_evaluation(area)

	var next_area: Area2D = _get_next_area()
	if next_area == null:
		_animate_axes()
	else:
		_select_evaluation(next_area)


func _deselect_evaluation(area: Area2D) -> void:
	_remove_highlight_from_paper()
	for use in uses:
		use.power_down()

	is_over_evaluation = false


func _remove_highlight_from_paper() -> void:
	if active_evaluation:
		active_evaluation.modulate = Color(1,1,1)


func _get_next_area() -> Area2D:
	var next_area: Area2D
	for area in _areas_below:
		area = area as Area2D
		if next_area == null or area.is_greater_than(next_area):
			next_area = area

	return next_area


func _animate_axes() -> void:
	var assigned_animation = node_animation_player.assigned_animation
	if is_over_evaluation:
		if assigned_animation == "close":
			node_animation_player.play("open")
			_play_arm_sound()
	else:
		if assigned_animation != "close":
			node_animation_player.play("close")
			_play_arm_sound()
			for axis in axes.values():
				axis = axis as Axis
				axis.reset_warmth()


func _play_arm_sound() -> void:
	audio_player.stream = PERSOMETER_ARMS
	audio_player.play()


func _on_raised():
	# NOTHING rises above me
	raise()
