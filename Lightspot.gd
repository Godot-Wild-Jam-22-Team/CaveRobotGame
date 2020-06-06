extends Area2D

func _ready():
	pass




func _on_Lightspot_body_entered(body):
	if body.has_method('lightspot_recharge'):
		body.lightspot_recharge()
