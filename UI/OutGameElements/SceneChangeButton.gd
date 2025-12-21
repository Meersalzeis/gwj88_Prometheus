extends Button

@export var scene_path : String

func _on_pressed() -> void:
	#needed for win/loose button
	get_tree().paused = false
	
	get_tree().change_scene_to_file(scene_path)
