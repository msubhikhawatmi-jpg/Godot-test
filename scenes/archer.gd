extends Sprite2D

@export var bullet_scene : PackedScene
@export var fire_rate = 1.0
@export var damage = 10

var target = null

func _ready():
	$Timer.wait_time = fire_rate
	$Timer.start()
	$Detection.body_entered.connect(_on_enemy_entered)
	$Detection.body_exited.connect(_on_enemy_exited)

func _on_enemy_entered(body):
	print("something entered range: ", body.name)
	if body.is_in_group("enemies"):
		print("enemy detected!")
		target = body

func _on_enemy_exited(body):
	if body == target:
		target = null

func _on_shoot_timer_timeout():
	print("timer fired, target is: ", target)
	if target != null and is_instance_valid(target):
		shoot()

func shoot():
	print("shooting!")
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = $ShootPoint.global_position
	var dir = (target.global_position - $ShootPoint.global_position).normalized()
	bullet.direction = dir
	rotation = dir.angle()
