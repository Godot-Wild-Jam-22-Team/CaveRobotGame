extends Character
class_name Robot

func _ready() -> void:
	placeholder_sprite.color = Color.blue
	path_visualization.default_color = Color.yellow

func path_ended() -> void:
	movement_path.reverse_path()
