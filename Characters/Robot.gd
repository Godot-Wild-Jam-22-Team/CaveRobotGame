extends Character
class_name Robot

func _ready() -> void:
	placeholder_sprite.color = Color.blue

func path_ended() -> void:
	movement_path.reverse_path()
