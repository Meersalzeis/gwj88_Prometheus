extends Node

signal enemy_killed
signal enemy_generated

signal no_fuel

signal health_updated
var health : int = 1

var fuel : float

var time : float = 0

var medium_ice = preload("res://Space/Resources/Ice_Medium_1.tscn")
var smol_ice = preload("res://Space/Resources/Ice_Small.tscn")

func break_breakble_into(breakable: Node2D, broken_part_preloaded) -> void:
	var break_pos = breakable.global_position
	murderize(breakable)
	
	var nr_of_parts = randi() % 3 + 2
	print("broken into " + str(nr_of_parts) + " parts")
	for i in nr_of_parts:
		var new_broken_part = broken_part_preloaded.instantiate()
		new_broken_part.global_position = break_pos + Vector2(randi() % 100 - 50, randi() % 100 - 50)
		
		#root > (Globals, Level > Background, Ice, [...] ))
		var ice_section = get_tree().root.get_child(1).get_child(1)
		# add as child to level, to remove them upon level reset/main menu
		# deferred b.c. error message from engine
		(func(): ice_section.add_child(new_broken_part)).call_deferred()

func murderize(node : Node) -> void:
	node.get_parent().remove_child(node)
	node.hide()
	node.set_process(false)
	node.queue_free()

func round_to_dec(num: float, digit : int):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)
