extends CharacterBody2D

@export var normal_speed = 10000
@export var turn_speed_base = PI * 0.30
@export var mitosis_time : int = 8
@export var mitosis_variance_time : float = 0.75

var player_ship
var xplus_to_yminus = 0.5 * PI
var mitosis_timer = 0
var own_pattern = preload("res://Space/Enemies/Swarmer.tscn")

func _ready() -> void:
	player_ship = get_tree().get_nodes_in_group("Player_Ship")[0]
	mitosis_timer = - randf_range(0, mitosis_variance_time)

func _physics_process(delta: float) -> void:
	turn(delta)
	move_with(delta, normal_speed)
	mitosis_calc(delta)

func turn(delta : float):
	var turn_speed = turn_speed_base * delta
	var target_rotation = (player_ship.global_position - global_position ).angle()
	
	if abs(target_rotation - rotation) < turn_speed :
		rotation = target_rotation
		
	else:            # bool == bool <=> bool xand bool
		if target_rotation < rotation == (abs(target_rotation - rotation) < PI):
			rotation = rotation - turn_speed
		else:
			rotation = rotation + turn_speed

func move_with(delta : float, speed : float):
	velocity = Vector2.from_angle(rotation).normalized() * speed * delta
	move_and_slide()

func mitosis_calc(delta : float):
	mitosis_timer += delta
	if mitosis_timer >= mitosis_time:
		mitosis_timer -= (mitosis_time + randf_range(0, mitosis_variance_time) )
		do_mitosis()

func do_mitosis():
	var new_copy : Node2D = own_pattern.instantiate()
	new_copy.rotation = self.rotation
	new_copy.global_position = self.global_position + get_mitosis_offset()
	
	# Add to same wave! important
	get_parent().add_child(new_copy)
	Globals.enemy_generated.emit()

func get_mitosis_offset() -> Vector2:
	if randi() % 2 == 1:
		if randi() % 2 == 1:
			return Vector2(randi() % 25 - 50, randi() % 25 - 50)
		else:
			return Vector2(randi() % 25 - 50, randi() % 25 + 50)
	
	#else
	if randi() % 2 == 1:
			return Vector2(randi() % 25 + 50, randi() % 25 - 50)
	else:
		return Vector2(randi() % 25 + 50, randi() % 25 + 50)

func hit_by_laser():
	Globals.murderize(self)
	Globals.enemy_killed.emit()
