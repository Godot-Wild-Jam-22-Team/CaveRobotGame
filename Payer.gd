extends Character
class_name Astronaut

onready var tween = $Tween
export(float) var speed = 5
export(int) var grid_size = 16
var inputs = {"Right": Vector2.RIGHT,
			"Left": Vector2.LEFT,
			"Up": Vector2.UP,
			"Down": Vector2.DOWN}
onready var ray = $RayCast2D

func _ready():
	position = position.snapped(Vector2.ONE * grid_size)
	position += Vector2.ONE * grid_size/2

func _unhandled_input(event):
		if tween.is_active():
			return
		for dir in inputs.keys():
			if event.is_action_pressed(dir):
				move(dir)
	
func move(dir):
	ray.cast_to = inputs[dir] * grid_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		move_tween(inputs[dir])

	
func move_tween(dir):
		tween.interpolate_property(self, "position",
			position, position + dir * grid_size,
			1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween.start()
