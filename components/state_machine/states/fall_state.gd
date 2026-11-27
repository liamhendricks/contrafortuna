class_name FallState extends MoveState

@export var coyote_time : float = 0.1

var coyote_timer : float = 0.0

func enter(data : Dictionary = {}) -> void:
	super(data)
	coyote_timer = coyote_time

func process(delta : float) -> void:
	coyote_timer -= delta

func physics_process(_delta : float) -> void:
	var ib : InputBucket = state_controller.get_input_bucket()

	if ib.actions.has(InputBucket.MOVES.BURSTING) && can_burst():
		machine.transition("burst")
		return

	if character.is_on_floor():
		if ib.actions.has(InputBucket.MOVES.MOVING):
			machine.transition("run")
			return
		else:
			machine.transition("idle")
			return

	if ib.actions.has(InputBucket.MOVES.JUMPING) && can_jump():
		machine.transition("jump")
		return

	if character.raycast_component.any_colliding() && character.character_data.can_slide():
		machine.transition("wall_slide")
		return

func can_burst() -> bool:
	return character.character_data.can_burst()

func can_jump() -> bool:
	if character.character_data.can_jump():
		if coyote_timer > 0.0:
			return true

	return false
