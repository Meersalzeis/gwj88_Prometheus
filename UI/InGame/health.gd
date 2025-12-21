extends Control

func _ready() -> void:
	Globals.health_updated.connect(relabel)

func relabel():
	$Label.text = "Health: " + str(Globals.health)
