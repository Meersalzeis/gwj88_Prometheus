extends CharacterBody2D

@export var jump_speed = 35000
@export var normal_speed = 12000
@export var jump_duration : float = 1.0
@export var jump_cooldown : float = 4.0
@export var turn_speed_base : float = PI * 0.23

var player_ship
var jump_timer = 0
var is_in_jump : bool = false
var xplus_to_yminus = 0.5 * PI

func _ready() -> void:
	player_ship = get_tree().get_nodes_in_group("Player_Ship")[0]

func _physics_process(delta: float) -> void:
	if is_in_jump:
		move_in_jump(delta)
	else:
		move_normal(delta)
	
	jump_timer = max(jump_timer - delta, 0)

func move_normal(delta: float):
	turn(delta)
	move_with(delta, normal_speed)
	
	if jump_timer == 0:
		if (player_ship.position - self.position).length() < jump_duration * jump_speed:
			if abs((player_ship.global_position - global_position ).angle() - rotation) < turn_speed_base * 3:
				jump_timer = jump_duration
				is_in_jump = true

func move_in_jump(delta : float):
	move_with(delta, jump_speed)
	
	if jump_timer == 0:
		jump_timer = jump_cooldown
		is_in_jump = false

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
