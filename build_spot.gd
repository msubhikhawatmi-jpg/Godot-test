extends Area2D

signal spot_clicked(position)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		spot_clicked.emit(global_position)
