extends Control

@export var bus_id : int = 1
@export var mm_music_player : AudioStreamPlayer
var level = 1

func _on_button_pressed() -> void:
	new_level(1)

func _on_button_2_pressed() -> void:
	new_level(2)

func _on_button_3_pressed() -> void:
	new_level(3)

func _on_button_4_pressed() -> void:
	new_level(4)

func new_level(new_level : int):
	level = new_level
	set_audio()
	set_button_colors()
	mm_music_player.play()

func set_audio():
	if level == 4:
		AudioServer.set_bus_mute(bus_id, true)
		print("audio bus " + str(bus_id) + " on level 4 / mute")
		return
	
	#else
	AudioServer.set_bus_mute(bus_id, false)
	
	if level == 1:
		AudioServer.set_bus_volume_linear(bus_id, 1)
	elif level == 2:
		AudioServer.set_bus_volume_linear(bus_id, 0.666)
	else: 
		AudioServer.set_bus_volume_linear(bus_id, 0.333)
	print("audio bus " + str(bus_id) + " on level " + str(level))

func set_button_colors():
	if level <= 3:
		$Button3.modulate = Color.ORANGE
	else:
		$Button3.modulate = Color.DIM_GRAY
	
	if level <= 2:
		$Button2.modulate = Color.YELLOW
	else:
		$Button2.modulate = Color.DIM_GRAY
	
	if level == 1:
		$Button.modulate = Color.GREEN
	else:
		$Button.modulate = Color.DIM_GRAY

func _ready():
	$Button.modulate = Color.GREEN
	$Button2.modulate = Color.YELLOW
	$Button3.modulate = Color.ORANGE
	$Button4.modulate = Color.RED
