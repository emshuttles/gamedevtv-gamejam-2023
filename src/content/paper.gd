class_name Paper
extends Control


export(bool) var is_evaluation
export(bool) var is_job_request
export(String) var candidate_name
export(Enums.Job) var correct_job
export(int) var kind
export(int) var analytical
export(Enums.Job) var desired_job
export(int) var engineer_interest
export(int) var art_therapist_interest
export(int) var toy_maker_interest
export(Texture) var portrait


onready var node_portrait:Sprite = find_node("Portrait")


func _ready() -> void:
	change_portrait()


func get_candidate() -> Candidate:
	return Candidate.new(candidate_name, correct_job, desired_job, portrait)


func change_portrait():
	node_portrait.texture = portrait
