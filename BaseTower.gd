extends Node2D
class_name BaseTower

enum TargetMode { NEAREST, FURTHEST, FIRST, LAST, STRONGEST, WEAKEST }

@export var damage: float = 25.0
@export var fire_rate: float = 1.0
@export var target_mode: TargetMode = TargetMode.FIRST
@export var bullet_scene: PackedScene

@onready var detection = $Detection
@onready var shoot_point = $Shootpoint
@onready var timer = $Timer

var target = null
var targets = []

func _ready():
	timer.wait_time = fire_rate
	timer.start()
	detection.body_entered.connect(_on_body_entered)
	detection.body_exited.connect(_on_body_exited)
	timer.timeout.connect(_on_timer_timeout)

func _on_body_entered(body):
	if body is CharacterBody2D:
		targets.append(body)

func _on_body_exited(body):
	if body in targets:
		targets.erase(body)

func get_target():
	targets = targets.filter(func(t): return is_instance_valid(t))
	if targets.is_empty():
		return null
	
	match target_mode:
		TargetMode.NEAREST:
			return targets.reduce(func(a, b): 
				return a if global_position.distance_to(a.global_position) < global_position.distance_to(b.global_position) else b)
		TargetMode.FURTHEST:
			return targets.reduce(func(a, b): 
				return a if global_position.distance_to(a.global_position) > global_position.distance_to(b.global_position) else b)
		TargetMode.FIRST:
			return targets.reduce(func(a, b): 
				return a if a.follow.progress_ratio > b.follow.progress_ratio else b)
		TargetMode.LAST:
			return targets.reduce(func(a, b): 
				return a if a.follow.progress_ratio < b.follow.progress_ratio else b)
		TargetMode.STRONGEST:
			return targets.reduce(func(a, b): 
				return a if a.health > b.health else b)
		TargetMode.WEAKEST:
			return targets.reduce(func(a, b): 
				return a if a.health < b.health else b)
	
	return null

func _on_timer_timeout():
	target = get_target()
	if target != null:
		shoot()

func shoot():
	if target == null:
		return
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_position = shoot_point.global_position
	bullet.init(target, damage)
