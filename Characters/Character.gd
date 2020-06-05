extends Area2D

class_name Character
#base for robot and astronaut, create instanced scenes to develop both of them
#manage here grid movement and progress bar updates

signal energy_changed(new_value)

#remote transform should be used to control position of a progress bar on top of character

#add max speed for movement
#robots should have an array of positions to follow on every turn

#robots need a method get_repaired() that should restore battery and functionality

var energy: float = 100 setget set_energy #both energy and oxygen

func _ready() -> void:
	pass # Replace with function body.

func initialize(position: Vector2, cell_size: Vector2)  -> void:
	# call from level or game scene
	# place in middle of grid cell
	# set all inital values
	#cell size is passed as argument 
	pass

func move(direction: Vector2) -> void:
	# call from _process method or upon turn change 
	# input should be a normalized vector (so values between -1 and +1)
	# calculate new position using grid size information 
	
	# raycasts should be used to check if a near cell is empty or if it is not possible to move so do not calculate new position
	
	pass

func set_energy(value: float) -> void:
	energy = value
	emit_signal("energy_changed", energy) #will update progress bar


