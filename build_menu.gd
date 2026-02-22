extends Control

signal tower_selected(tower_scene)

@export var archer_scene: PackedScene
@export var mage_scene: PackedScene
@export var canon_scene: PackedScene

func _ready():
	visible = false

func show_at(pos: Vector2):
	global_position = pos
	visible = true

func _on_archer_button_pressed():
	tower_selected.emit(archer_scene)
	visible = false

func _on_mage_button_pressed():
	tower_selected.emit(mage_scene)
	visible = false
	
func _on_canon_button_pressed():
	tower_selected.emit(mage_scene)
	visible = false
