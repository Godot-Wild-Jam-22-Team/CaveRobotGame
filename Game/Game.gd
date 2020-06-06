extends Node

# I would add a unique timer for turns in whole game scene and then call single characters on turn change
#astronaut should be out of turn management, free to move but on grid

#add new Robots to Robots scene to manage all added scenes

var astronaut_spawn_position : Vector2 = Vector2(0, 0) # this is a placeholder for now

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_spawn_astronaut()

func _spawn_astronaut() -> void:
	var astronaut_instance : Astronaut = Resources.astronaut_scene.instance() as Astronaut
	astronaut_instance.initialize(astronaut_spawn_position)
	add_child(astronaut_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
