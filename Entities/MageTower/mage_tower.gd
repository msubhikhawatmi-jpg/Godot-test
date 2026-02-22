extends BaseTower

@onready var beam = $BeamLine
@onready var shoot_sound = $beam_sound

func _ready():
	super._ready()
	beam.visible = false

func shoot():
	if target == null:
		return
	
	target.take_damage(damage)
	shoot_sound.play()
	show_beam()

func show_beam():
	beam.clear_points()
	beam.add_point(to_local(shoot_point.global_position))
	beam.add_point(to_local(target.global_position))
	beam.visible = true
	
	await get_tree().create_timer(0.15).timeout
	beam.visible = false
