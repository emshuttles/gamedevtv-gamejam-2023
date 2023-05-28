class_name JobRequest
extends Paper


# TODO: Update after finalizing the scene
func _ready() -> void:
	var name: Label = $PLACEHOLDER/Name
	name.text = candidate_name
	var correct_job_label: Label = $PLACEHOLDER/CorrectJob
	correct_job_label.text = Consts.JOB_NAMES[correct_job]
	var desired_job_label: Label = $PLACEHOLDER/DesiredJob
	desired_job_label.text = Consts.JOB_NAMES[desired_job]
	$Portrait.texture = portrait
