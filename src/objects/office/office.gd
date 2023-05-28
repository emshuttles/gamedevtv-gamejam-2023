extends Node


export(int) var engineer_quota
export(int) var art_therapist_quota
export(int) var toy_maker_quota

var _trays := [] # of Tray
var _papers := [] # of Paper
var _fileable_papers_count: int = 0

onready var game: Node = get_parent()
onready var letter_spawn: Position2D = $"%LetterSpawn"
onready var end_button: Button = $"%EndButton"


func _ready() -> void:
	_trays = get_tree().get_nodes_in_group("tray")
	_papers = get_tree().get_nodes_in_group("paper")

	Signals.connect("tray_updated", self, "_on_tray_updated")

	_create_job_requests()
	_count_fileable_papers()


func _create_job_requests() -> void:
	for candidate in game.pending_job_request:
		candidate = candidate as Candidate
		var job_request: Paper = Scenes.job_request.instance()
		_set_paper_variables(job_request, candidate)
		var spawn_point: Vector2 = _get_spawn_point()
		job_request.rect_position = spawn_point
		add_child(job_request)


func _set_paper_variables(paper: Paper, candidate: Candidate) -> void:
	paper.candidate_name = candidate.name
	paper.correct_job = candidate.correct_job
	paper.desired_job = candidate.desired_job


func _get_spawn_point() -> Vector2:
	var random_x_offset: int = randi() % 20
	var x_offset_sign: int = -1 if randf() < 0.5 else 1
	var random_y_offset: int = randi() % 20
	var y_offset_sign: int = -1 if randf() < 0.5 else 1
	var spawn_point := Vector2(letter_spawn.position.x, letter_spawn.position.y)
	spawn_point.x += x_offset_sign * random_x_offset
	spawn_point.y += y_offset_sign * random_y_offset
	return spawn_point


func _count_fileable_papers() -> void:
	for paper in _papers:
		# paper could be instructions, etc.
		if Utils.is_fileable(paper):
			_fileable_papers_count += 1


func _on_EndDay_pressed() -> void:
	var result: Result = _get_result()
	Signals.emit_signal("day_ended", result)
	Signals.emit_signal("scene_transition", Scenes.day_x)
	queue_free()


func _get_result() -> Result:
	var result := Result.new(engineer_quota, art_therapist_quota, toy_maker_quota)
	for tray in _trays:
		tray = tray as Tray
		match tray.job:
			Enums.Job.ENGINEER:
				var engineer_candidates: Array = _get_candidates(tray)
				result.engineer_candidates = engineer_candidates
			Enums.Job.ART_THERAPIST:
				var art_therapist_candidates: Array = _get_candidates(tray)
				result.art_therapist_candidates = art_therapist_candidates
			Enums.Job.TOY_MAKER:
				var toy_maker_candidates: Array = _get_candidates(tray)
				result.toy_maker_candidates = toy_maker_candidates

	return result


func _get_candidates(tray: Tray) -> Array:
	var candidates := []
	for paper in tray.papers_held:
		paper = paper as Paper
		var candidate: Candidate = paper.get_candidate()
		candidates.append(candidate)

	return candidates


func _on_tray_updated() -> void:
	var filed_papers_count: int = 0
	for tray in _trays:
		tray = tray as Tray
		filed_papers_count += tray.papers_held.size()

	end_button.disabled = filed_papers_count != _fileable_papers_count
