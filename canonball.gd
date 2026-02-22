extends Area2D

@export var speed: float = 200.0

var target = null
var damage: float = 0.0
var explosion_radius: float = 100.0
var target_last_pos: Vector2  # store last known position

@onready var anim = $AnimatedSprite2D

func init(t, d, radius):
	target = t
	damage = d
	explosion_radius = radius
	target_last_pos = t.global_position

func _ready():
	anim.play("fly")

func _process(delta):
	# update last known position while target is alive
	if target != null and is_instance_valid(target):
		target_last_pos = target.global_position
	
	# always move toward last known position
	var direction = (target_last_pos - global_position).normalized()
	global_position += direction * speed * delta
	
	if global_position.distance_to(target_last_pos) < 10.0:
		explode()

func explode():
	set_process(false)
	anim.play("explosion")
	
	var bodies = get_tree().get_nodes_in_group("enemies")
	for body in bodies:
		if is_instance_valid(body) and body.has_method("take_damage"):
			if global_position.distance_to(body.global_position) <= explosion_radius:
				body.take_damage(damage)
	
	await anim.animation_finished
	queue_free()
