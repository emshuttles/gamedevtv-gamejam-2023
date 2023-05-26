class_name Paper
extends Control


export(String) var candidate_name
export(Enums.Job) var correct_job
export(int, 1, 5) var kind
export(int, 1, 5) var analytical
export(Enums.Job) var desired_job
export(int, 1, 5) var engineer_interest
export(int, 1, 5) var art_therapist_interest
export(int, 1, 5) var toy_maker_interest


func get_candidate() -> Candidate:
	return Candidate.new(candidate_name, correct_job, desired_job)
