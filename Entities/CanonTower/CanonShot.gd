extends BaseTower


func shoot():
	if target == null:
		return
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_position = shoot_point.global_position
	bullet.init(target, damage)
