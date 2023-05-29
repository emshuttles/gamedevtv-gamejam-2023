class_name Game
extends Node


const CORRECT_ASSIGNMENT_GOAL := 5
const DESIRED_ASSIGNMENT_GOAL := 7

var day: int = 0
var pending_job_requests := [] # of Candidate
var correct_assignment_count: int = 0
var desired_assignment_count: int = 0
var was_perfect_today := true

var _pending_thank_yous := [] # of Candidate
var _has_requested_before := [] # of Candidate
var _assignments := {
	1: {
		"engineer_candidates": [], # of Candidate
		"art_therapist_candidates": [], # of Candidate
		"toy_maker_candidates": [], # of Candidate
	},
	2: {
		"engineer_candidates": [], # of Candidate
		"art_therapist_candidates": [], # of Candidate
		"toy_maker_candidates": [], # of Candidate
	},
	3: {
		"engineer_candidates": [], # of Candidate
		"art_therapist_candidates": [], # of Candidate
		"toy_maker_candidates": [], # of Candidate
	},
}


func _ready() -> void:
	randomize()
	Signals.connect("scene_transition",self,"new_scene")
	Signals.connect("day_ended", self, "_on_day_ended")


func new_scene(packed_scene:PackedScene):
	var scene:Node = packed_scene.instance()
	add_child(scene)


func get_assigned_job(candidate: Candidate) -> int:
	var is_engineer: bool = _has_candidate(_assignments[day - 1].engineer_candidates, candidate)
	if is_engineer:
		return Enums.Job.ENGINEER

	var is_art_therapist: bool = _has_candidate(_assignments[day - 1].art_therapist_candidates, candidate)
	if is_art_therapist:
		return Enums.Job.ART_THERAPIST

	var is_toy_maker: bool = _has_candidate(_assignments[day - 1].toy_maker_candidates, candidate)
	if is_toy_maker:
		return Enums.Job.TOY_MAKER

	assert(false, "This candidate wasn't assigned a job yesterday.")
	return -1


func _has_candidate(array: Array, target: Candidate) -> bool:
	for candidate in array:
		if candidate.name == target.name:
			return true

	return false


func _on_day_ended(result: Result) -> void:
	# Reset for new day
	pending_job_requests = []
	was_perfect_today = true
	correct_assignment_count = 0
	desired_assignment_count = 0

	_add_result_to_assignments(result)
	_process_assignments()
	return


func _add_result_to_assignments(result: Result) -> void:
	for engineer_candidate in result.engineer_candidates:
		# In case this is a job change, remove from other jobs
		_remove_from_previous_assignment(engineer_candidate)
		_assignments[day].engineer_candidates.append(engineer_candidate)

	for art_therapist_candidate in result.art_therapist_candidates:
		_remove_from_previous_assignment(art_therapist_candidate)
		_assignments[day].art_therapist_candidates.append(art_therapist_candidate)

	for toy_maker_candidate in result.toy_maker_candidates:
		_remove_from_previous_assignment(toy_maker_candidate)
		_assignments[day].toy_maker_candidates.append(toy_maker_candidate)


func _remove_from_previous_assignment(candidate: Candidate) -> void:
	if day > 1:
		_erase_candidate(_assignments[day - 1].engineer_candidates, candidate)
		_erase_candidate(_assignments[day - 1].art_therapist_candidates, candidate)
		_erase_candidate(_assignments[day - 1].toy_maker_candidates, candidate)


func _erase_candidate(array: Array, candidate: Candidate) -> void:
	var idx_to_erase: int = -1
	for idx in range(array.size()):
		var current: Candidate = array[idx]
		if current.name == candidate.name:
			idx_to_erase = idx

	if idx_to_erase > -1:
		array.remove(idx_to_erase)


func _process_assignments() -> void:
	for current_day in range(1, day + 1):
		for engineer_candidate in _assignments[current_day].engineer_candidates:
			_process_candidate(current_day, engineer_candidate, Enums.Job.ENGINEER)

		for art_therapist_candidate in _assignments[current_day].art_therapist_candidates:
			_process_candidate(current_day, art_therapist_candidate, Enums.Job.ART_THERAPIST)

		for toy_maker_candidate in _assignments[current_day].toy_maker_candidates:
			_process_candidate(current_day, toy_maker_candidate, Enums.Job.TOY_MAKER)


func _process_candidate(current_day: int, candidate: Candidate, job: int) -> void:
	if candidate.correct_job == job:
		correct_assignment_count += 1
	else:
		if current_day == day:
			was_perfect_today = false

	if candidate.desired_job == job:
		desired_assignment_count += 1
		# Candidates only thank you if you give them the job they want despite
		# being suited to a different job
		if candidate.correct_job != job:
			_pending_thank_yous.append(candidate)
	else:
		if not _has_candidate(_has_requested_before, candidate):
			pending_job_requests.append(candidate)
			_has_requested_before.append(candidate)
