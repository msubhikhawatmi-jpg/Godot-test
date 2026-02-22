extends Area2D

@export var speed: float = 300.0
@export var damage: float = 25.0

var target = null

func init(t, d):
	target = t
	damage = d

func _process(delta):
	if target == null or not is_instance_valid(target):
		queue_free()
		return
	
	# move toward target
	var direction = (target.global_position - global_position).normalized()
	global_position += direction * speed * delta
	
	# check if close enough to hit
	if global_position.distance_to(target.global_position) < 10.0:
		target.take_damage(damage)
		queue_free()
