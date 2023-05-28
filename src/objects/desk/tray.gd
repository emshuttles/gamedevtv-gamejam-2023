class_name Tray
extends Area2D


export(Enums.Job) var job

var papers_held := [] # of Paper

onready var label: Label = $Label
onready var leather: TextureRect = $"%Leather"


func _ready() -> void:
	label.text = Consts.JOB_NAMES[job]

	if job == Enums.Job.ENGINEER:
		leather.modulate = Color8(255,255,255)
	elif job == Enums.Job.ART_THERAPIST:
		leather.modulate = Color8(107,255,175)
	elif job == Enums.Job.TOY_MAKER:
		leather.modulate = Color8(158,228,255)

func _on_Tray_area_entered(area: Area2D) -> void:
	if not Utils.is_fileable(area.owner):
		return

	papers_held.append(area.owner)
	Signals.emit_signal("tray_updated")


func _on_Tray_area_exited(area: Area2D) -> void:
	if not Utils.is_fileable(area.owner):
		return

	papers_held.erase(area.owner)
	Signals.emit_signal("tray_updated")
