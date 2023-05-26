class_name Tray
extends Area2D


const JOB_NAMES := {
	Enums.Job.ENGINEER: "Engineer",
	Enums.Job.ART_THERAPIST: "Art Therapist",
	Enums.Job.TOY_MAKER: "Toy Maker",
}

export(Enums.Job) var job

var papers_held := [] # of Paper

onready var label := $Label as Label


func _ready() -> void:
	label.text = JOB_NAMES[job]


func _on_Tray_area_entered(area: Area2D) -> void:
	if not area.owner is Paper:
		return

	papers_held.append(area.owner)
	Signals.emit_signal("tray_updated")


func _on_Tray_area_exited(area: Area2D) -> void:
	if not area.owner is Paper:
		return

	papers_held.erase(area.owner)
	Signals.emit_signal("tray_updated")
