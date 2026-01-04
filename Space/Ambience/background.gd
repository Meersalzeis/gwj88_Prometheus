extends Node2D


func _ready():
	get_viewport().size_changed.connect(adjust_to_resize)
	adjust_to_resize()

func adjust_to_resize():
	# ensures the background will have save margin around viewport in case camera turns
	# Size bigger than web display for downloadables
	self.global_position = Vector2(-1080, -1920)
	print("resize triggered")
