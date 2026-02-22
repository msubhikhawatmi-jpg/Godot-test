extends Control

signal tower_selected(tower_scene)

@export var archer_scene: PackedScene
@export var mage_scene: PackedScene
@export var archer_cost: int = 100
@export var mage_cost: int = 150

var level: Node2D

func _ready():
	visible = false
	level = get_tree().current_scene

func show_at(pos: Vector2):
	global_position = pos
	visible = true

func _on_archer_button_pressed():
	if level.spend_money(archer_cost):
		tower_selected.emit(archer_scene)
		visible = false
	else:
		print("Not enough money!")

func _on_mage_button_pressed():
	if level.spend_money(mage_cost):
		tower_selected.emit(mage_scene)
		visible = false
	else:
		print("Not enough money!")
