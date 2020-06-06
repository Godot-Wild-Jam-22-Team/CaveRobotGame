extends Character
class_name Astronaut

func _ready() -> void:
	placeholder_sprite.color = Color.white

func path_ended() -> void:
	movement_path.delete_path()
