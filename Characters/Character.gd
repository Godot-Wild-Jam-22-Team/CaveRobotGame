extends Area2D

class_name Character
#base for robot and astronaut, create instanced scenes to develop both of them
#manage here grid movement and progress bar updates

signal energy_changed(new_value)

onready var collision_ray : RayCast2D = $RayCast2D as RayCast2D
onready var movement_tween : Tween = $Tween as Tween

#remote transform should be used to control position of a progress bar on top of character

#add max speed for movement
#robots should have an array of positions to follow on every turn

#robots need a method get_repaired() that should restore battery and functionality
var speed : float = 5.0
var energy: float = 100 setget set_energy #both energy and oxygen

func _ready() -> void:
	position = position.snapped(Vector2.ONE * Global.UNIT_SIZE)
	position += Vector2.ONE * Global.UNIT_SIZE/2

func initialize(pos: Vector2)  -> void:
	# call from level or game scene
	# place in middle of grid cell
	# set all inital values
	#cell size is passed as argument 
	position = pos

func move(direction: Vector2) -> void:
	# call from _process method or upon turn change 
	# input should be a normalized vector (so values between -1 and +1)
	# calculate new position using grid size information 
	
	# raycasts should be used to check if a near cell is empty or if it is not possible to move so do not calculate new position
	collision_ray.cast_to = direction * Global.UNIT_SIZE
	collision_ray.force_raycast_update()
	if !collision_ray.is_colliding():
		_move_tween(direction)
	
func _move_tween(direction : Vector2) -> void:
	movement_tween.interpolate_property(self, "position",
			position, position + direction * Global.UNIT_SIZE,
			1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	movement_tween.start()

func set_energy(value: float) -> void:
	energy = value
	emit_signal("energy_changed", energy) #will update progress bar

