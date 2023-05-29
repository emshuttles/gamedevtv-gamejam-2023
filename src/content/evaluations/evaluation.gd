extends Paper


const CHECKBOX_PATHS := {
	1: "VBoxContainer/HBoxContainer/CheckBox1",
	2: "VBoxContainer/HBoxContainer/CheckBox2",
	3: "VBoxContainer/HBoxContainer/CheckBox3",
	4: "VBoxContainer/HBoxContainer/CheckBox4",
	5: "VBoxContainer/HBoxContainer/CheckBox5",
}

onready var name_node: VBoxContainer = $Evaluation/VBoxContainer/Name
onready var kind_statement: MarginContainer = $Evaluation/VBoxContainer/Statements/Statement1
onready var analytical_statement: MarginContainer = $Evaluation/VBoxContainer/Statements/Statement2
onready var engineer_statement: MarginContainer = $Evaluation/VBoxContainer/Statements/Statement3
onready var therapist_statement: MarginContainer = $Evaluation/VBoxContainer/Statements/Statement4
onready var toy_maker_statement: MarginContainer = $Evaluation/VBoxContainer/Statements/Statement5


func _ready() -> void:
	var name_label: Label = name_node.get_node("Label7")
	name_label.text = candidate_name

#	var kind_path: String = CHECKBOX_PATHS[kind]
#	kind_statement.get_node(kind_path).pressed = true

	var analytical_path: String = CHECKBOX_PATHS[analytical]
	analytical_statement.get_node(analytical_path).pressed = true

	var engineer_path: String = CHECKBOX_PATHS[engineer_interest]
	engineer_statement.get_node(engineer_path).pressed = true

	var therapist_path: String = CHECKBOX_PATHS[art_therapist_interest]
	therapist_statement.get_node(therapist_path).pressed = true

	var toy_maker_path: String = CHECKBOX_PATHS[toy_maker_interest]
	toy_maker_statement.get_node(toy_maker_path).pressed = true
