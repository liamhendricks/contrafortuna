extends MoveState
class_name RunState

func enter(data : Dictionary = {}) -> void:
	super(data)
	character.character_data.active_jump = 0

func physics_process(_delta : float) -> void:
	var ib : InputBucket = state_controller.get_input_bucket()
	if ib.actions.has(InputBucket.MOVES.JUMPING) && can_jump():
		machine.transition("jump")
		return
	if !ib.actions.has(InputBucket.MOVES.MOVING):
		machine.transition("idle")
		return

func can_jump() -> bool:
	return true
