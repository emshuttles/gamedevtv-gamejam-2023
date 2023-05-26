extends Node


const IDEAL_TRAITS := {
	Enums.Job.ENGINEER: {
		Enums.Trait.ANALYTICAL: 5,
		Enums.Trait.KIND: 1,
	},
	Enums.Job.ART_THERAPIST: {
		Enums.Trait.ANALYTICAL: 1,
		Enums.Trait.KIND: 5,
	},
	Enums.Job.TOY_MAKER: {
		Enums.Trait.ANALYTICAL: 4,
		Enums.Trait.KIND: 4,
	},
}

var day: int = 0


func _ready() -> void:
	Signals.connect("scene_transition",self,"new_scene")


func new_scene(packed_scene:PackedScene):
	var scene:Node = packed_scene.instance()
	add_child(scene)
