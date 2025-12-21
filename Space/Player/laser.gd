extends Area2D

func set_laser(set_enabled : bool):
	$Hurtbox.disabled = !set_enabled
	
	if set_enabled:
		$Line2D3.show()
		$Line2D2.show()
		$Line2D.show()
	else:
		$Line2D3.hide()
		$Line2D2.hide()
		$Line2D.hide()



func _on_body_entered(body: Node2D) -> void:
	print("laser hit on " + body.name)
	if body.is_in_group("Laser_Interaction"):
		body.hit_by_laser()
