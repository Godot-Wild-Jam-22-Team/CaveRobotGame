extends Node

#astronaut should be out of turn management, free to move but on grid

onready var robot_node : Node = $Node2D/Robots as Node
onready var turn_timer : Timer = $Node2D/TurnTimer

var last_draw_cell := Vector2.ZERO

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
	start_game()

func start_game() -> void:
	turn_timer.start()

#can be simplified, astronaut should always be in scene (we can set him with editor)
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
	last_draw_cell = $Node2D/GroundMap.world_to_map(selected_object.position)
	selected_object.movement_path.delete_path()

func _on_turn_button_up():
	Events.emit_signal("turn_tick")


func _on_TurnTimer_timeout() -> void:
	Events.emit_signal("turn_tick")

func _process(_delta: float) -> void:
	if selected_object:
		if Input.is_action_pressed("left_click"):
			var click_point = $Node2D.get_global_mouse_position()
			var cell = $Node2D/GroundMap.world_to_map(click_point)
			if cell != last_draw_cell:
				var direction = cell - last_draw_cell
				last_draw_cell = cell
				selected_object.movement_path.add_node_to_path(direction)
		elif Input.is_action_just_released("left_click"):
			selected_object.selected = false
			selected_object = null
