extends Control

func _process(delta: float) -> void:
	Globals.fuel = Globals.fuel - delta
	$Label.text = "fuel " + str(Globals.round_to_dec(Globals.fuel, 1))
	
	if Globals.fuel <= 0:
		Globals.no_fuel.emit()
