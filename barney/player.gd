extends CharacterBody3D
class_name Player

@export var hit_controller : HitController

func _ready() -> void:
	assert(hit_controller, "hit_controller not set")

func _on_bat_hit_body_entered(body: Node3D) -> void:
	hit_controller.hit_body(body)
