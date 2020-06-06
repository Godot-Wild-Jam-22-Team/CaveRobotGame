extends Character
class_name Robot

export (int) var battery_points = 100

func _ready() -> void:
	placeholder_sprite.color = Color.blue
	path_visualization.default_color = Color.yellow

func check_battery():
	if battery_points <= 0:
		battery_points = 0
		can_move = false

func lightspot_recharge():
	can_move = false
	while battery_points < 100:
		print("Recharging battery: " + battery_points)
		battery_points += 2
	can_move = true

func path_ended() -> void:
	movement_path.reverse_path()

