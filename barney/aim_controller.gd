extends Node
class_name AimController

@export var aim_assistant : AimAssistant
@export var max_aim_angle_x: float = 0.8
@export var max_aim_angle_y: float = 0.5

var aim_yaw : float = 0.0
var aim_pitch : float = 0.0
var is_aiming : bool = false

func _ready() -> void:
	assert(aim_assistant, "aim_assistant not set")
	hide_aim_assistant()

func _physics_process(delta: float) -> void:
	aim_assistant.rotation.y = aim_yaw
	aim_assistant.rotation.x = aim_pitch

func _input(event: InputEvent) -> void:
	if is_aiming and event is InputEventMouseMotion:
		var invert_x : int = -1 if GameConfig.config.invert_aim_x else 1
		var invert_y : int = -1 if GameConfig.config.invert_aim_y else 1
		
		aim_yaw -= event.relative.x * GameConfig.config.aim_sensitivity_x * invert_x
		aim_pitch -= event.relative.y * GameConfig.config.aim_sensitivity_y * invert_y
		
		aim_yaw = clamp(aim_yaw, -max_aim_angle_x, max_aim_angle_x)
		aim_pitch = clamp(aim_pitch, -max_aim_angle_y, max_aim_angle_y)

func show_aim_assistant() -> void:
	is_aiming = true
	aim_assistant.visible = true
	if GameConfig.config.reset_aim_on_windup:
		aim_yaw = 0
		aim_pitch = 0
		
func hide_aim_assistant() -> void:
	is_aiming = false
	aim_assistant.visible = false

func get_hit_direction() -> Vector3:
	return -aim_assistant.global_transform.basis.z.normalized()
	

func _on_player_controller_wound_up() -> void:
	show_aim_assistant()


func _on_player_controller_shot() -> void:
	hide_aim_assistant()
