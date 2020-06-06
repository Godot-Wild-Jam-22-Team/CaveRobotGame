extends Node

# I would add a unique timer for turns in whole game scene and then call single characters on turn change
#astronaut should be out of turn management, free to move but on grid

#add new Robots to Robots scene to manage all added scenes
onready var robot_node : Node = $Node2D/Robots as Node


var astronaut_spawn_position : Vector2 = Vector2(0, 0) * Global.UNIT_SIZE # this is a placeholder for now
var robot_spawn_position : Vector2 = Vector2(2, 2) * Global.UNIT_SIZE
var robot_path : Array = [
	Vector2.UP,
	Vector2.UP,
	Vector2.RIGHT,
	Vector2.RIGHT,
	Vector2.DOWN
]
var astronaut_path : Array = [
	Vector2.DOWN,
	Vector2.DOWN,
	Vector2.RIGHT,
	Vector2.RIGHT,
	Vector2.DOWN
]

var selected_object : Character = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_spawn_character(Resources.astronaut_scene, astronaut_spawn_position, self)
	_spawn_character(Resources.robot_scene, robot_spawn_position, robot_node)

func _spawn_character(scene : PackedScene, pos : Vector2, parent : Node) -> void:
	var instance := scene.instance() as Character
	instance.initialize(pos)
	instance.movement_path.path = astronaut_path if scene == Resources.astronaut_scene else robot_path # for movement testing
	instance.movement_path.start_point = astronaut_spawn_position if scene == Resources.astronaut_scene else robot_spawn_position # for movement testing
	instance.connect("selected", self, "character_selected")
	parent.add_child(instance)

func character_selected(object : Character) -> void:
	if selected_object != null and selected_object != object:
		selected_object.selected = false
	selected_object = object
	
func _on_turn_button_up():
	Events.emit_signal("turn_tick")
