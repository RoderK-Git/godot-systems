extends Resource
class_name GameConfigResource

@export var reset_aim_on_windup: bool = false

@export var invert_aim_x: bool = true
@export var invert_aim_y: bool = true

@export_range(0.001, 0.1, 0.001)
var aim_sensitivity_x: float = 0.005

@export_range(0.001, 0.1, 0.001)
var aim_sensitivity_y: float = 0.005
