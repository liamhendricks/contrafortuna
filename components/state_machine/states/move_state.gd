extends State
class_name MoveState

@export var movement_data : MovementData

func enter(_data : Dictionary = {}) -> void:
	character.movement_component.gravity = movement_data.gravity
	character.movement_component.acceleration = movement_data.acceleration
	character.movement_component.drag = movement_data.drag

func handle_transitions(_input_bucket : InputBucket) -> void:
	pass
