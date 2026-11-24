extends MoveState
class_name IdleState

#@export var animation_param : String = ""
#@export var animation_value : String = ""
#character.model_provider_component.animation_tree.set(animation_param, animation_value)

@export var jump_buffer_time : float = 0.1

func enter(_data : Dictionary = {}) -> void:
	pass

func physics_process(delta : float) -> void:
	super(delta)
	if !character.is_on_floor():
		machine.transition("fall")
		return

func can_jump() -> bool:
	return true
