class_name Result
extends Reference


var engineer_quota: int = 0
var art_therapist_quota: int = 0
var toy_maker_quota: int = 0
var engineer_candidates := [] # of Candidate
var art_therapist_candidates := [] # of Candidate
var toy_maker_candidates := [] # of Candidate


func _init(new_engineer_quota: int, new_art_therapist_quota: int,
		new_toy_maker_quota: int) -> void:
	engineer_quota = new_engineer_quota
	art_therapist_quota = new_art_therapist_quota
	toy_maker_quota = new_toy_maker_quota
