extends MoveState
class_name IdleState

#@export var animation_param : String = ""
#@export var animation_value : String = ""
#character.model_provider_component.animation_tree.set(animation_param, animation_value)

func enter(data : Dictionary = {}) -> void:
	super(data)
	
	#reset jumps / slides
	character.character_data.active_jump = 0
	character.character_data.active_slide = true

func physics_process(_delta : float) -> void:
	var ib : InputBucket = state_controller.get_input_bucket()
	if ib.actions.has(InputBucket.MOVES.JUMPING) && can_jump():
		machine.transition("jump")
		return

	if ib.actions.has(InputBucket.MOVES.BURSTING):
		machine.transition("burst")
		return

	if !character.is_on_floor():
		machine.transition("fall")
		return
	else:
		if ib.actions.has(InputBucket.MOVES.MOVING):
			machine.transition("run")
			return

func can_jump() -> bool:
	return true
