extends CharacterBody2D

@export var max_health: float = 100.0
@export var speed: float = 100.0

@onready var anim = $AnimatedSprite2D

var health: float = max_health
var follow: PathFollow2D

func _ready():
	health = max_health
	follow = get_parent()

func _process(delta):
	var prev_pos = follow.position
	follow.progress += speed * delta
	
	if follow.progress_ratio >= 1.0:
		follow.queue_free()
		return
	
	var movement = follow.position - prev_pos
	
	if abs(movement.x) > abs(movement.y):
		anim.play("walk_left")
	else:
		anim.play("normal")

func take_damage(amount: float):
	health -= amount
	flash_red()
	if health <= 0:
		die()

func flash_red():
	anim.modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.15).timeout
	anim.modulate = Color(1, 1, 1)

func die():
	follow.queue_free()
