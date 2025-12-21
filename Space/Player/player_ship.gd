extends CharacterBody2D

@export var start_fuel : float = 100

@export var acc : int = 300
@export var de_acc : int = 200
@export var turn : float = PI * 0.4
@export var max_velo : int = 18000

@export var laser_base_cost_per_second : float = 5

var xplus_to_yminus = 0.5 * PI

func _ready():
	Globals.fuel = start_fuel

func _physics_process(delta: float) -> void:
	calc_movement(delta)
	calc_laser(delta)

func calc_movement(delta : float) -> void:
	if Input.is_action_pressed("ui_brake"):
		if velocity.length() < (de_acc * delta):
			velocity = Vector2.ZERO
		else:
			velocity = velocity - (velocity.normalized() * de_acc * delta)
	
	# already normalized
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	rotate(input_direction.x * turn * delta)
	
	var cur_acc = Vector2.from_angle(rotation + xplus_to_yminus).normalized() * (input_direction.y * acc * delta)
	velocity += cur_acc
	velocity = velocity.limit_length(max_velo)
	move_and_slide()

func calc_laser(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		Globals.fuel = Globals.fuel - laser_base_cost_per_second * delta
		$Laser.set_laser(true)
	else:
		$Laser.set_laser(false)

func get_hit() -> void:
	Globals.health = Globals.health - 1
	Globals.health_updated.emit()
