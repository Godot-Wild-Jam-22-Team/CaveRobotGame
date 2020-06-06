extends Node2D
class_name MovementPath

signal path_ended()

var path : Array = [] setget set_path
var path_size : int = 0
var path_index : int = 0

func set_path(value : Array) -> void:
	path = value.duplicate()
	path_size = path.size()

func get_direction():
	var temp = path[path_index]
	path_index += 1
	if path_index >= path_size:
		path_index = 0
		emit_signal("path_ended")
	return temp

func reverse_path() -> void:
	var new_path : Array = []
	var temp_path = path.duplicate()
	temp_path.invert()
	for p in temp_path:
		match p:
			Global.MoveDirection.UP:
				new_path.append(Global.MoveDirection.DOWN)
			Global.MoveDirection.DOWN:
				new_path.append(Global.MoveDirection.UP)
			Global.MoveDirection.RIGHT:
				new_path.append(Global.MoveDirection.LEFT)
			Global.MoveDirection.LEFT:
				new_path.append(Global.MoveDirection.RIGHT)
	path = new_path

func delete_path() -> void:
	path_size = 0
	path_index = 0
	path.clear()
