extends Area2D

class_name Character
#base for robot and astronaut, create instanced scenes to develop both of them
#manage here grid movement and progress bar updates

signal energy_changed(new_value)
signal selected(object)

export (bool) var can_move = true

onready var collision_ray : RayCast2D = $RayCast2D as RayCast2D
onready var movement_tween : Tween = $Tween as Tween
onready var placeholder_sprite : Polygon2D = $SpritePlaceHolder as Polygon2D
onready var path_visualization : Line2D = $Line2D as Line2D

#remote transform should be used to control position of a progress bar on top of character

#add max speed for movement
#robots should have an array of positions to follow on every turn

#robots need a method get_repaired() that should restore battery and functionality
var selected : bool = false setget set_selected
var selected_overlay_color : Color = Color.red
var speed : float = 5.0
var energy: float = 100 setget set_energy #both energy and oxygen
#var directions : Dictionary = {
#	Global.MoveDirection.UP : Vector2.UP,
#	Global.MoveDirection.DOWN : Vector2.DOWN,
#	Global.MoveDirection.LEFT : Vector2.LEFT,
#	Global.MoveDirection.RIGHT : Vector2.RIGHT
#}

var movement_path : MovementPath = null
var path_index : int = 0

func _ready() -> void:
	position = position.snapped(Vector2.ONE * Global.UNIT_SIZE)
	position += Vector2.ONE * Global.UNIT_SIZE/2
	
	path_visualization.clear_points()
	path_visualization.set_as_toplevel(true)
	
	movement_path.connect("path_ended", self, "path_ended")
	Events.connect("turn_tick", self, "turn_tick")

func _process(_delta : float) -> void:
	path_visualization.points = movement_path.visualize_path()

# abstract method, implemented in astronaut/robot
func path_ended() -> void:
	pass
	
func turn_tick() -> void:
	set_selected(false)
	if not movement_tween.is_active() and movement_path.path_size > 0:
		move(movement_path.get_direction())

func initialize(pos: Vector2)  -> void:
	# call from level or game scene
	# place in middle of grid cell
	# set all inital values
	#cell size is passed as argument 
	position = pos
	movement_path = MovementPath.new()

func move(direction: Vector2) -> void:
	# call from _process method or upon turn change 
	# input should be a normalized vector (so values between -1 and +1)
	# calculate new position using grid size information 
	
	# raycasts should be used to check if a near cell is empty or if it is not possible to move so do not calculate new position
	collision_ray.cast_to = direction * Global.UNIT_SIZE
	collision_ray.force_raycast_update()
	if not collision_ray.is_colliding() and not selected:
		_move_tween(direction)
	
func _move_tween(direction : Vector2) -> void:
	movement_tween.interpolate_property(self, "position",
			position, position + direction * Global.UNIT_SIZE,
			1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	movement_tween.start()

func set_selected(value : bool) -> void:
	selected = value
	placeholder_sprite.self_modulate = selected_overlay_color if selected else Color.white

func set_energy(value: float) -> void:
	energy = value
	emit_signal("energy_changed", energy) #will update progress bar

func _unhandled_input(event : InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	if event.button_index == BUTTON_RIGHT and event.pressed and selected:
		set_selected(false)
		
func _on_Character_input_event(viewport : Node, event : InputEvent, shape_idx : int) -> void:
	if not event is InputEventMouseButton:
		return
	if event.button_index == BUTTON_LEFT and event.pressed:
		set_selected(true)
		emit_signal("selected", self)
