extends Node2D


export var target_x:int = 3
export var target_y:int = 5

var use_count:int = 0
export var use_max:int = 4

func _ready() -> void:
#	$WarmtY.modulate.a = 0
#	$WarmtX.modulate.a = 0
	pass


func _on_ButtonActivate_pressed() -> void:
	if use_count < use_max:
		var use_highlight = $Uses.get_child(use_count)
		use_highlight.visible = false
		use_count += 1
		
		$AxisX.check(target_x)
		$AxisY.check(target_y)
		
	else:
		print("out of uses!")
