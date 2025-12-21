extends Node2D

# might be a next wave or win condition
@export var next_stage: Node
@export var is_active : bool = false

#var enemies_in_wave 
#var nr_of_participants : int = 0

func _ready():
	#enemies_in_wave = get_children()
	#nr_of_participants = len(enemies_in_wave)
	Globals.enemy_killed.connect(enemy_died)
	#Globals.enemy_generated.connect(enemy_gen)
	
	if !is_active:
		for enemy in get_children():
			enemy.hide()
			enemy.process_mode = Node.PROCESS_MODE_DISABLED

func set_active():
	is_active = true
	for enemy in get_children():
		enemy.show()
		enemy.process_mode = Node.PROCESS_MODE_INHERIT

#func enemy_gen():
	#if is_active:
		#nr_of_participants += 1

func enemy_died():
	if !is_active:
		print(name + " is not active")
		return
	
	print(name + " has " + str(len(get_children())) + " enemies / children")
	if len(get_children()) == 0:
		# deferred to prevent this enemy_killed singnal to count for next wave
		call_deferred("activate_next_stage")

func activate_next_stage():
	next_stage.set_active()
