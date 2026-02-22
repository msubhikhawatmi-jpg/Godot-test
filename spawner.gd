extends Node

@export var enemy_scene: PackedScene
@export var path: NodePath
@export var enemies_per_wave: int = 5
@export var time_between_enemies: float = 1.0
@export var time_between_waves: float = 5.0

var current_wave: int = 0
var enemies_spawned: int = 0

func _ready():
	start_wave()

func start_wave():
	current_wave += 1
	enemies_spawned = 0
	print("Wave ", current_wave, " starting!")
	spawn_next_enemy()

func spawn_next_enemy():
	if enemies_spawned >= enemies_per_wave:
		await get_tree().create_timer(time_between_waves).timeout
		start_wave()
		return
	
	var follow = PathFollow2D.new()
	follow.rotates = false
	get_node(path).add_child(follow)
	
	var enemy = enemy_scene.instantiate()
	follow.add_child(enemy)
	enemy.follow = follow
	
	enemies_spawned += 1
	await get_tree().create_timer(time_between_enemies).timeout
	spawn_next_enemy()
