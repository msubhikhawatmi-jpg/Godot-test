extends BaseTower

@export var explosion_radius: float = 100.0

func shoot():
	if target == null:
		return
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_position = shoot_point.global_position
	bullet.init(target, damage, explosion_radius)
