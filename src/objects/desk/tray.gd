class_name Tray
extends Area2D


export(Enums.Job) var job

var papers_held := [] # of Paper

onready var label: Label = $Label


func _ready() -> void:
	label.text = Consts.JOB_NAMES[job]


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
