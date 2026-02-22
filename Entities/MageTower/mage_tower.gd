extends Node2D

enum TargetMode { NEAREST, FURTHEST }

@export var target_mode: TargetMode = TargetMode.NEAREST
@export var damage: float = 25.0
@export var fire_rate: float = 1.0
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

func _on_body_entered(body):
	if body is CharacterBody2D:
		targets.append(body)

func _on_body_exited(body):
	if body in targets:
		targets.erase(body)

func get_target():
	var chosen = null
	var chosen_dist = INF if target_mode == TargetMode.NEAREST else -INF
	
	for t in targets:
		if not is_instance_valid(t):
			continue
		var dist = global_position.distance_to(t.global_position)
		if target_mode == TargetMode.NEAREST and dist < chosen_dist:
			chosen_dist = dist
			chosen = t
		elif target_mode == TargetMode.FURTHEST and dist > chosen_dist:
			chosen_dist = dist
			chosen = t
	
	return chosen

func _on_timer_timeout():
	targets = targets.filter(func(t): return is_instance_valid(t))
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
