extends Paper


onready var game: Node = get_node("/root/Game")


# TODO: Update after finalizing the scene
func _ready() -> void:
	var name: Label = $PLACEHOLDER/Name
	name.text = candidate_name
	var assigned_job_label: Label = $PLACEHOLDER/AssignedJob
	var assigned_job: int = game.get_assigned_job(get_candidate())
	assigned_job_label.text = "Assigned job: " + Consts.JOB_NAMES[assigned_job]
	var desired_job_label: Label = $PLACEHOLDER/DesiredJob
	desired_job_label.text = "Desired job: " + Consts.JOB_NAMES[desired_job]
