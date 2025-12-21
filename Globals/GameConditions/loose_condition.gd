extends CenterContainer

@export var this_level_path : String 

func _ready():
	hide()
	$VBoxContainer/TryAgain.scene_path = this_level_path
	Globals.health_updated.connect(check_health_left)
	Globals.no_fuel.connect(switch_to_game_lost_fuel)
	print("win condition no enemies left ready, may not be active")

func check_health_left():
	if Globals.health <= 0:
		switch_to_game_lost_health()

func switch_to_game_lost_health() -> void:
	$VBoxContainer/Label.text = $VBoxContainer/Label.text + "Your spaceship was trashed. Try again?"
	get_tree().paused = true
	show()

func switch_to_game_lost_fuel() -> void:
	$VBoxContainer/Label.text = $VBoxContainer/Label.text + "No fuel left. Try again?"
	get_tree().paused = true
	show()
