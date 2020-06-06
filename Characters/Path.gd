extends Node2D
class_name MovementPath

signal path_ended()

var path : Array = [] setget set_path
var start_point : Vector2 = Vector2.ZERO
var path_size : int = 0
var path_index : int = 0
var directions : PoolVector2Array = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT
]

func set_path(value : Array) -> void:
	path = value.duplicate()
	path_size = path.size()

func visualize_path() -> PoolVector2Array:
	var visualization := PoolVector2Array([])
	var temp_point : Vector2 = start_point
	visualization.append(temp_point)
	for p in path:
		temp_point += p * Global.UNIT_SIZE
		visualization.append(temp_point)
	return visualization

func add_node_to_path(direction : Vector2):
	path.append(direction)
	path_size += 1
	
func remove_node_from_path(index : int):
	path.remove(index)
	path_size -=1

func get_direction() -> Vector2:
	var dir = path[path_index]
	path_index += 1
	if path_index >= path_size:
		emit_signal("path_ended")
	return dir

func reverse_path() -> void:
	start_point = visualize_path()[-1] # TODO: find a better way to do this
	var new_path : Array = []
	var temp_path = path.duplicate()
	temp_path.invert()
	for p in temp_path:
		match p:
			Vector2.UP:
				new_path.append(Vector2.DOWN)
			Vector2.DOWN:
				new_path.append(Vector2.UP)
			Vector2.RIGHT:
				new_path.append(Vector2.LEFT)
			Vector2.LEFT:
				new_path.append(Vector2.RIGHT)
	path = new_path
	path_index = 0

func delete_path() -> void:
	path_size = 0
	path_index = 0
	path.clear()
