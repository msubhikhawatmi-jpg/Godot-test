extends Area2D

signal spot_clicked(spot, position)

var is_occupied: bool = false

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if not is_occupied and not get_tree().current_scene.build_menu.visible:
			spot_clicked.emit(self, global_position)

func occupy():
	is_occupied = true
