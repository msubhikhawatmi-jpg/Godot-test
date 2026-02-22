extends BaseTower

@onready var shoot_sound = $arrow_sound

func shoot():
	if target == null:
		return
	shoot_sound.play()
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_position = shoot_point.global_position
	bullet.init(target, damage)
