extends Node2D

@export var starting_money: int = 500

var money: int = 0
var selected_position: Vector2
var current_spot = null

signal money_changed(new_amount)

@onready var build_menu = $BuildMenu
@onready var hud = $HUD

func _ready():
	money = starting_money
	hud.setup(self)
	for spot in get_tree().get_nodes_in_group("build_spots"):
		spot.spot_clicked.connect(_on_spot_clicked)

func _on_spot_clicked(spot, position: Vector2):
	selected_position = position
	current_spot = spot
	build_menu.show_at(position)

func _on_build_menu_tower_selected(tower_scene: PackedScene):
	var tower = tower_scene.instantiate()
	add_child(tower)
	tower.global_position = selected_position
	build_menu.visible = false
	if current_spot != null:
		current_spot.occupy()
		current_spot = null

func add_money(amount: int):
	money += amount
	money_changed.emit(money)

func spend_money(amount: int) -> bool:
	if money >= amount:
		money -= amount
		money_changed.emit(money)
		return true
	return false
