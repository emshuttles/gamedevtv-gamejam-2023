extends Node


const CORRECT_ASSIGNMENT_GOAL := 5
const DESIRED_ASSIGNMENT_GOAL := 7

var day: int = 0
var correct_assignment_count: int = 0
var desired_assignment_count: int = 0
 # Depending on how we present the reprimand and/or final results, we may need more info
var has_met_quotas := false
var want_different_job := [] # of Candidate


func _ready() -> void:
	Signals.connect("scene_transition",self,"new_scene")
	Signals.connect("day_ended", self, "_on_day_ended")


func new_scene(packed_scene:PackedScene):
	var scene:Node = packed_scene.instance()
	add_child(scene)


func _on_day_ended(result: Result) -> void:
	has_met_quotas = true
	for engineering_candidate in result.engineer_candidates:
		_process_candidate(engineering_candidate, Enums.Job.ENGINEER)

	for art_therapist_candidate in result.art_therapist_candidates:
		_process_candidate(art_therapist_candidate, Enums.Job.ART_THERAPIST)

	for toy_maker_candidate in result.toy_maker_candidates:
		_process_candidate(toy_maker_candidate, Enums.Job.TOY_MAKER)


func _process_candidate(candidate: Candidate, job: int) -> void:
	if candidate.correct_job == job:
		correct_assignment_count += 1
	else:
		# Because the quotas match the number of candidates, one mistake means missing a quota
		has_met_quotas = false

	if candidate.desired_job == job:
		desired_assignment_count += 1
	else:
		want_different_job.append(candidate)
