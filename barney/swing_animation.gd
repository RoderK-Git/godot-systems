extends Node
class_name SwingAnimation

@export var monitor : Area3D
@export var bat_center: Node3D
@export var bat_hand: Node3D
@export var swing_speed: float = 4.0

var bat_center_rest_angle_deg : float
var bat_hand_rest_angle_deg : float
var bat_center_swing_angle_deg: float = 0.0
var bat_hand_swing_angle_deg: float = 0.0

var is_swinging: bool = false
var current_bat_center_target_angle: float = 0.0
var current_bat_hand_target_angle: float = 0.0

func _ready() -> void:
	assert(monitor, "monitor not set")
	assert(bat_center, "bat_center not set")
	assert(bat_hand, "bat_hand not set")
	bat_center_rest_angle_deg = rad_to_deg(bat_center.rotation.y)
	bat_hand_rest_angle_deg = rad_to_deg(bat_hand.rotation.z)
	current_bat_center_target_angle = bat_center_rest_angle_deg
	current_bat_hand_target_angle = bat_hand_rest_angle_deg
	monitor.monitoring = false
	
func _get_configuration_warnings() -> PackedStringArray:
	var result : PackedStringArray = []
	if not monitor: result.append("monitor not set") 
	if not bat_center: result.append("bat_center not set")
	if not bat_hand: result.append("bat_hand not set")
	return result	

func _physics_process(delta: float) -> void:	
	var current_bat_center_angle : float = rad_to_deg(bat_center.rotation.y)
	var new_bat_center_angle : float = move_toward(current_bat_center_angle, current_bat_center_target_angle, swing_speed * 180.0 * delta)
	var current_bat_hand_angle : float = rad_to_deg(bat_hand.rotation.z)
	var new_bat_hand_angle : float = move_toward(current_bat_hand_angle, current_bat_hand_target_angle, swing_speed * 180.0 * delta)
	
	_apply_bat_angle(new_bat_center_angle, new_bat_hand_angle)

	if monitor.monitoring and not is_swinging	:
		monitor.monitoring = false
		#print("Monitoring stopped")
#
	if not monitor.monitoring and is_swinging and new_bat_center_angle < 30:
		monitor.monitoring = true
		#print("Monitoring")
			

	if is_swinging and is_equal_approx(new_bat_center_angle, bat_center_swing_angle_deg) and is_equal_approx(new_bat_hand_angle, bat_hand_swing_angle_deg):
		is_swinging = false
		current_bat_center_target_angle = bat_center_rest_angle_deg
		current_bat_hand_target_angle = bat_hand_rest_angle_deg

func start_swing() -> void:
	is_swinging = true
	current_bat_center_target_angle = bat_center_swing_angle_deg
	current_bat_hand_target_angle = bat_hand_swing_angle_deg

func _apply_bat_angle(center_angle_deg: float, hand_angle_deg: float) -> void:
	bat_center.rotation.y = deg_to_rad(center_angle_deg)
	bat_hand.rotation.z = deg_to_rad(hand_angle_deg) 


func _on_player_controller_shot() -> void:
	start_swing()
