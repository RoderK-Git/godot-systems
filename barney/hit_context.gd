extends Resource
class_name HitContext

var direction: Vector3
var power: float
var spin: float
var hitter: Node

func debug_print() -> void:
	print("HitContext: ")
	print(" - direction=" + str(direction))
	print(" - power=" + str(power))
	print(" - spin=" + str(spin))
	print(" - hitter=" + str(hitter))
	
