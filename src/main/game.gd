extends Node


var day: int = 0


func _ready() -> void:
	Signals.connect("scene_transition",self,"new_scene")


func new_scene(packed_scene:PackedScene):
	var scene:Node = packed_scene.instance()
	add_child(scene)
