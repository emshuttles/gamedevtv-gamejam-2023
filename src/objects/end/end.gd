extends MarginContainer


onready var game: Game = get_parent()
onready var numbers:Label = $"%Numbers"
onready var result:Label = $"%Result"
onready var bonus_result: Label = $"%BonusResult"


func _ready() -> void:
	numbers.text = str("You got ", game.correct_assignment_count, " out of the ", game.CORRECT_ASSIGNMENT_GOAL, " required assignments right (in the eyes of the Empire).")
	if game.correct_assignment_count >= game.CORRECT_ASSIGNMENT_GOAL:
		result.text = "You're hired!"
	else:
		result.text = "You were fired."

	if game.desired_assignment_count >= game.DESIRED_ASSIGNMENT_GOAL:
		bonus_result.text = "However, you gave everyone the job they wanted. May that comfort you during your job search."
	else:
		bonus_result.visible = false

