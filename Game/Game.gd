extends Node

# I would add a unique timer for turns in whole game scene and then call single characters on turn change
#astronaut should be out of turn management, free to move but on grid

#add new Robots to Robots scene to manage all added scenes

var astronaut_spawn_position : Vector2 = Vector2(0, 0) * Global.UNIT_SIZE # this is a placeholder for now
var robot_spawn_position : Vector2 = Vector2(2, 2) * Global.UNIT_SIZE
var robot_path : Array = [
	Global.MoveDirection.UP,
	Global.MoveDirection.UP,
	Global.MoveDirection.RIGHT,
	Global.MoveDirection.RIGHT,
	Global.MoveDirection.DOWN,
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_spawn_astronaut()
	_spawn_robot()

func _spawn_astronaut() -> void:
	var astronaut_instance = Resources.astronaut_scene.instance()
	astronaut_instance.initialize(astronaut_spawn_position)
	add_child(astronaut_instance)
	
func _spawn_robot() -> void:
	var robot_instance = Resources.robot_scene.instance()
	robot_instance.initialize(robot_spawn_position)
	robot_instance.movement_path = robot_path
	add_child(robot_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
