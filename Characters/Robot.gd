extends Character
class_name Robot

var movement_path : Array = [] setget set_movement_path
var path_index : int = 0
var path_size : int = 0

func _ready() -> void:
	placeholder_sprite.color = Color.blue

func set_movement_path(path : Array) -> void:
	movement_path = path
	path_size = movement_path.size()

func _process(_delta : float) -> void:
	if not movement_tween.is_active() and path_size > 0:
		move(_get_path_direction())

func _get_path_direction() -> Vector2:
	var direction = movement_path[path_index]
	path_index += 1
	if path_index >= path_size:
		path_index = 0
		movement_path = _reverse_path()
	return directions[direction]

func _reverse_path() -> Array:
	var new_path : Array = []
	movement_path.invert()
	for path in movement_path:
		match path:
			Global.MoveDirection.UP:
				new_path.append(Global.MoveDirection.DOWN)
			Global.MoveDirection.DOWN:
				new_path.append(Global.MoveDirection.UP)
			Global.MoveDirection.RIGHT:
				new_path.append(Global.MoveDirection.LEFT)
			Global.MoveDirection.LEFT:
				new_path.append(Global.MoveDirection.RIGHT)
	return new_path
