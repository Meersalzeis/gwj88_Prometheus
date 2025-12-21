extends RigidBody2D

@export var breaks_into_small_instead_of_medium : bool = true

func hit_by_laser() -> void:
	if breaks_into_small_instead_of_medium:
		Globals.break_breakble_into(self, Globals.smol_ice)
	else:
		Globals.break_breakble_into(self, Globals.medium_ice)
