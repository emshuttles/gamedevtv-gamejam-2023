extends Node


export(int) var engineer_quota
export(int) var art_therapist_quota
export(int) var toy_maker_quota

var _trays := [] # of Tray
var _papers := [] # of Paper

onready var game := get_parent() as Node
onready var end_button := find_node("EndButton") as Button


func _ready() -> void:
	_trays = get_tree().get_nodes_in_group("tray")
	_papers = get_tree().get_nodes_in_group("paper")

	Signals.connect("tray_updated", self, "_on_tray_updated")


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
	var num_of_filed_papers: int = 0
	for tray in _trays:
		tray = tray as Tray
		num_of_filed_papers += tray.papers_held.size()

	var num_of_papers_to_file: int = 0
	for paper in _papers:
		# paper could be instructions, etc.
		if paper is Paper and (paper.is_evaluation or paper.is_job_change):
			num_of_papers_to_file += 1

	end_button.disabled = num_of_filed_papers != num_of_papers_to_file
