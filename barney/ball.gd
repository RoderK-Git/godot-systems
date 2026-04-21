extends Node3D

enum BallState {
	READY,
	FLYING,
	DEAD
}

@export var speed: float = 18.0
@export var lifetime: float = 2.0

var state: BallState = BallState.READY
var direction: Vector3 = Vector3.ZERO
var age: float = 0.0
var start_pos : Vector3

func _ready() -> void:
	start_pos = position

func _physics_process(delta: float) -> void:
	if state != BallState.FLYING:
		return
	
	global_position += direction * speed * delta

	age += delta
	if age >= lifetime:
		reset()
	
func reset() -> void:
	age = 0.0
	position = start_pos
	state = BallState.READY
	speed = 0.0
	direction = Vector3.ZERO
	

func on_bat_hit(hit_context : HitContext) -> void:
	print("OUCH")
	if state != BallState.READY:
		return

	direction = hit_context.direction
	speed = hit_context.power
	state = BallState.FLYING
