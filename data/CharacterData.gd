extends Resource
class_name CharacterData

@export var total_jumps : int = 2
@export var total_bursts : int = 1

var active_jump : int = 0
var active_burst : int = 0
var active_slide : bool = false

func can_jump() -> bool:
	return active_jump < total_jumps

func can_burst() -> bool:
	return active_burst < total_bursts

func can_slide() -> bool:
	return active_slide
