extends CharacterBody2D

var speed = 400
var damage = 10
var direction = Vector2.RIGHT

func _physics_process(delta):
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()	


func _on_timeout() -> void:
	pass # Replace with function body.
