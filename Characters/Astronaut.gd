extends Character
class_name Astronaut

var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

func _unhandled_input(event):
		if movement_tween.is_active():
			return
		for dir in inputs.keys():
			if event.is_action_pressed(dir):
				move(inputs[dir])
