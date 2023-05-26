extends Node


export var quota_engineer: int = 0
export var quota_art_therapist: int = 0
export var quota_toy_maker: int = 0

var _trays := [] # of Trays
var _papers := [] # of Papers

onready var game := get_parent() as Node
onready var end_button := $EndButton as Button


func _ready() -> void:
	_trays = get_tree().get_nodes_in_group("tray")
	_papers = get_tree().get_nodes_in_group("paper")

	Signals.connect("tray_updated", self, "_on_tray_updated")


func _on_EndDay_pressed() -> void:
	Signals.emit_signal("scene_transition", Scenes.day_x)
	queue_free()


func _on_tray_updated() -> void:
	var num_of_filed_papers: int = 0
	for tray in _trays:
		tray = tray as Tray
		num_of_filed_papers += tray.papers_held.size()

	end_button.disabled = num_of_filed_papers != _papers.size()
