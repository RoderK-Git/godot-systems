extends Node
class_name HitController

@export var player_controller : PlayerController
@export var swing_animation : SwingAnimation
@export var aim_controller : AimController

func _ready() -> void:
	assert(player_controller, "player_controller not set")
	assert(swing_animation, "swing_animation not set")
	assert(aim_controller, "aim_controller not set")


func hit_body(body: Node3D) -> void:
	print("Hit: " + str(body))
	if not swing_animation.is_swinging:
		return
	
	if body.has_method("on_bat_hit"):
		pass
		var hit_context = HitContext.new()
		hit_context.direction = aim_controller.get_hit_direction()
		hit_context.power = player_controller.shoot_power
		hit_context.debug_print()	
		body.on_bat_hit(hit_context)
