extends Node2D

@export var starting_money: int = 500

var money: int = 0
signal money_changed(new_amount)

@onready var build_menu = $BuildMenu
@onready var hud = $HUD

func _ready():
	money = starting_money
	hud.setup(self)

func add_money(amount: int):
	money += amount
	money_changed.emit(money)

func spend_money(amount: int) -> bool:
	if money >= amount:
		money -= amount
		money_changed.emit(money)
		return true
	return false

var selected_position: Vector2

func _on_build_spot_spot_clicked(position: Vector2):
	selected_position = position
	build_menu.show_at(position)

func _on_build_spot_2_spot_clicked(position: Vector2):
	selected_position = position
	build_menu.show_at(position)

func _on_build_spot_3_spot_clicked(position: Vector2):
	selected_position = position
	build_menu.show_at(position)

func _on_build_spot_4_spot_clicked(position: Vector2):
	selected_position = position
	build_menu.show_at(position)

func _on_build_spot_5_spot_clicked(position: Vector2):
	selected_position = position
	build_menu.show_at(position)

func _on_build_menu_tower_selected(tower_scene: PackedScene):
	var tower = tower_scene.instantiate()
	add_child(tower)
	tower.global_position = selected_position
	build_menu.visible = false
