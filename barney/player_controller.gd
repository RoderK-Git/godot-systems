extends Node
class_name PlayerController

@export var player : Node3D

@export var move_speed: float = 5.0
@export var shoot_power: float = 25.0
var is_winding_up: bool = false

signal wound_up
signal shot

func _ready() -> void:
	assert(player, "player not set")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			start_windup()
		else:
			release_shot()

func _physics_process(delta: float) -> void:
	var input_x : float = Input.get_axis("move_left", "move_right")
	
	var direction : Vector3 = Vector3.RIGHT * input_x
	
	player.velocity = direction * move_speed
	player.move_and_slide()

func start_windup() -> void:
	is_winding_up = true
	print("Winding up")
	wound_up.emit()

func release_shot() -> void:
	if not is_winding_up:
		return

	print("Shooting")
	is_winding_up = false
	shot.emit()
