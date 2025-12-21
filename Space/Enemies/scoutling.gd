extends CharacterBody2D

@export var normal_speed = 13000
@export var turn_speed_base = PI * 0.30

var player_ship
var xplus_to_yminus = 0.5 * PI

func _ready() -> void:
	player_ship = get_tree().get_nodes_in_group("Player_Ship")[0]

func _physics_process(delta: float) -> void:
	turn(delta)
	move_with(delta, normal_speed)

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

func hit_by_laser():
	Globals.murderize(self)
	Globals.enemy_killed.emit()
