extends Node2D

@export var damage: float = 25.0
@export var fire_rate: float = 1.0  # seconds between shots
@export var bullet_scene: PackedScene

@onready var detection = $Detection
@onready var shoot_point = $Shootpoint
@onready var timer = $Timer


var target = null

func _ready():
	timer.wait_time = fire_rate
	timer.start()
	detection.body_entered.connect(_on_body_entered)
	detection.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body is CharacterBody2D and target == null:
		target = body

func _on_body_exited(body):
	if body == target:
		target = null

func _on_timer_timeout():
	if target != null and is_instance_valid(target):
		shoot()

func shoot():
	if target == null:
		return
	
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_position = shoot_point.global_position
	bullet.init(target, damage)
