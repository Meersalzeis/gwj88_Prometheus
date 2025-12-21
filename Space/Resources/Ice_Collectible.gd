extends RigidBody2D

@export var fuel_bonus = 25

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Playership":
		Globals.fuel = Globals.fuel + fuel_bonus
		Globals.murderize(self)
