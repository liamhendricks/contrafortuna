extends MoveState
class_name JumpState

@export var jump_height : float = 5.0
@export var min_velocity_to_rejump : float = 2.0

func enter(data : Dictionary = {}) -> void:
	super(data)
	character.movement_component.jump(jump_height)
	character.character_data.active_jump += 1
	character.character_data.active_slide = true

func physics_process(_delta : float) -> void:
	var ib : InputBucket = state_controller.get_input_bucket()
	var colliding : bool = character.raycast_component.any_colliding()
	if ib.actions.has(InputBucket.MOVES.BURSTING):
		machine.transition("burst")
		return

	if ib.actions.has(InputBucket.MOVES.JUMPING) && character.velocity.y < min_velocity_to_rejump && can_jump():
		if colliding:
			machine.transition("wall_kick")
			return
		else:
			machine.transition("jump")
			return

	if colliding && character.velocity.y < 0.0 && character.character_data.can_slide():
		machine.transition("wall_slide")
		return

	if character.velocity.y < 0.0:
		machine.transition("fall")
		return

	if character.is_on_floor():
		machine.transition("idle")
		return

func can_jump() -> bool:
	return character.character_data.can_jump()
