class_name Axis
extends Node2D


onready var marker = $"%Marker"
onready var warmth = $"%Warmth"


func _ready() -> void:
	warmth.modulate.a = 0
	reset_warmth()


func reset_warmth():
	warmth.modulate = Color(0.2,0.2,0.2,1)


func check(target_value:int):
	var difference:int = abs(marker.value - target_value)
	if difference == 0:
		warmth.modulate = Color(1,0.3,0.2,1)
	elif difference == 1:
		warmth.modulate = Color(0.8,0.5,0.2,1)
	elif difference == 2:
		warmth.modulate = Color(0.5,0.5,0.5,1)
	elif difference == 3:
		warmth.modulate = Color(0.2,0.5,0.8,1)
	elif difference == 4:
		warmth.modulate = Color(0.2,0.3,1,1)
#	var alpha:float = difference / 4
#	warmth.modulate.a = 1 - alpha
