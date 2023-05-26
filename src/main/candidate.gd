class_name Candidate
extends Reference


var name := ""
var correct_job: int = 0 # Enums.Job
var desired_job: int = 0 # Enums.Job


func _init(new_name: String, new_correct_job: int, new_desired_job: int) -> void:
	name = new_name
	correct_job = new_correct_job
	desired_job = new_desired_job
