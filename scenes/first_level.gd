extends Node2D

@onready var build_menu = $BuildMenu

var selected_position: Vector2

func _on_build_spot_spot_clicked(position: Vector2):
	selected_position = position
	build_menu.show_at(position)

func _on_build_spot_2_spot_clicked(position: Vector2):
	selected_position = position
	build_menu.show_at(position)

func _on_build_menu_tower_selected(tower_scene: PackedScene):
	var tower = tower_scene.instantiate()
	add_child(tower)
	tower.global_position = selected_position
	build_menu.visible = false
