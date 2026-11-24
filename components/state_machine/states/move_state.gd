extends State
class_name MoveState

@export var priority : int = 0

func handle_transitions(input_bucket : InputBucket) -> void:
	if input_bucket.actions.has(InputBucket.MOVES.JUMPING) && can_jump():
		machine.transition("jump")
		return

func can_jump() -> bool:
	return false

func physics_process(_delta : float) -> void:
	handle_transitions(state_controller.get_input_bucket())
