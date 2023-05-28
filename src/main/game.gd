extends Node


const CORRECT_ASSIGNMENT_GOAL := 5
const DESIRED_ASSIGNMENT_GOAL := 7

var day: int = 0
var pending_job_request := [] # of Candidate

var _correct_assignment_count: int = 0
var _desired_assignment_count: int = 0
 # Depending on how we present the reprimand and/or final results, we may need more info
var _has_met_quotas := false
var _pending_thank_you := [] # of Candidate
var _has_requested_before := [] # of Candidate
var _current_assignments := {
	"engineer_quota": 0,
	"art_therapist_quota": 0,
	"toy_maker_quota": 0,
	"engineer_candidates": [], # of Candidate
	"art_therapist_candidates": [], # of Candidate
	"toy_maker_candidates": [], # of Candidate
}


func _ready() -> void:
	randomize()
	Signals.connect("scene_transition",self,"new_scene")
	Signals.connect("day_ended", self, "_on_day_ended")


func new_scene(packed_scene:PackedScene):
	var scene:Node = packed_scene.instance()
	add_child(scene)


func _on_day_ended(result: Result) -> void:
	# Reset for new day
	pending_job_request = []
	_has_met_quotas = true
	_correct_assignment_count = 0
	_desired_assignment_count = 0

	_current_assignments.engineer_quota += result.engineer_quota
	_current_assignments.art_therapist_quota += result.art_therapist_quota
	_current_assignments.toy_maker_quota += result.toy_maker_quota
	_current_assignments.engineer_candidates.append_array(result.engineer_candidates)
	_current_assignments.art_therapist_candidates.append_array(result.art_therapist_candidates)
	_current_assignments.toy_maker_candidates.append_array(result.toy_maker_candidates)

	_process_assignments()
	return


func _process_assignments() -> void:
	for engineering_candidate in _current_assignments.engineer_candidates:
		_process_candidate(engineering_candidate, Enums.Job.ENGINEER)

	for art_therapist_candidate in _current_assignments.art_therapist_candidates:
		_process_candidate(art_therapist_candidate, Enums.Job.ART_THERAPIST)

	for toy_maker_candidate in _current_assignments.toy_maker_candidates:
		_process_candidate(toy_maker_candidate, Enums.Job.TOY_MAKER)


func _process_candidate(candidate: Candidate, job: int) -> void:
	if candidate.correct_job == job:
		_correct_assignment_count += 1
	else:
		# Because sum of quotas == number of candidates, one mistake means missing a quota
		_has_met_quotas = false

	if candidate.desired_job == job:
		_desired_assignment_count += 1
		# Candidates only thank you if you give them the job they want despite
		# being suited to a different job
		if candidate.correct_job != job:
			_pending_thank_you.append(candidate)
	else:
		if not _has_requested_before.has(candidate):
			pending_job_request.append(candidate)
			_has_requested_before.append(candidate)
