extends Resource
class_name CharacterData

@export var total_jumps : int = 2

var active_jump : int = 0
var active_slide : bool = false

func can_jump() -> bool:
	return active_jump < total_jumps

func can_slide() -> bool:
	return active_slide
