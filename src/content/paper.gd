class_name Paper
extends Control


export(bool) var is_evaluation # So Persometer can differentiate from job change request
export(String) var candidate_name
export(Enums.Job) var correct_job
export(int) var kind
export(int) var analytical
export(Enums.Job) var desired_job
export(int) var engineer_interest
export(int) var art_therapist_interest
export(int) var toy_maker_interest


func get_candidate() -> Candidate:
	return Candidate.new(candidate_name, correct_job, desired_job)
