extends Character
class_name Robot

export (int) var MAX_BATTERY_CHARGE := 100
export (int) var BATTERY_CHARGE_AMOUNT := 10
var battery_points := 100 setget set_battery_points

func _ready() -> void:
	placeholder_sprite.color = Color.blue
	path_visualization.default_color = Color.yellow

func lightspot_recharge():
	can_move = false
	while battery_points < MAX_BATTERY_CHARGE:
		print("Recharging battery: " + str(battery_points))
		self.battery_points += BATTERY_CHARGE_AMOUNT
	can_move = true

func move(direction: Vector2) -> void:
	self.battery_points -= BATTERY_CHARGE_AMOUNT
	.move(direction)

func path_ended() -> void:
	movement_path.reverse_path()

func set_battery_points(value: int) -> void:
	battery_points = min(value, MAX_BATTERY_CHARGE)
	if battery_points <= 0:
		print("Empty battery")
		can_move = false
