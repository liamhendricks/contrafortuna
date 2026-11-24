extends MoveState
class_name JumpState

@export var minimum_jump_height : float = 10.0

func enter(_data : Dictionary = {}) -> void:
	character.movement_component.jump()
