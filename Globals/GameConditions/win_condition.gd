extends Control

@export var is_active : bool = false
@export var enemy_count : int = 1

func _ready():
	hide()
	Globals.enemy_killed.connect(check_enemies_left)
	Globals.enemy_generated.connect(enemy_gen)
	print("win condition no enemies left ready, may not be active")

func set_active():
	switch_to_game_win()

func check_enemies_left():
	enemy_count -= 1
	print("check enemies triggered, active: " + str(is_active) + " enemy count is now " + str(enemy_count))
	if is_active:
		if enemy_count == 0:
			switch_to_game_win()

func enemy_gen():
	if is_active:
		enemy_count += 1

func switch_to_game_win() -> void:
	get_tree().paused = true
	show()
