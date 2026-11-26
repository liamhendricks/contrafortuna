extends MoveState
class_name WallSlideState

@export var wall_slide_time : float = 0.5

var wall_slide_timer : float = 0.0

func enter(data : Dictionary = {}) -> void:
	super(data)
	wall_slide_timer = wall_slide_time
	character.character_data.active_slide = false

func physics_process(delta : float) -> void:
	wall_slide_timer -= delta

	var ib : InputBucket = state_controller.get_input_bucket()
	var colliding : bool = character.raycast_component.any_colliding()

	if ib.actions.has(InputBucket.MOVES.JUMPING) && character.character_data.can_jump():
		if colliding:
			machine.transition("wall_kick")
			return
		else:
			machine.transition("jump")
			return

	if character.is_on_floor():
		machine.transition("idle")
		return

	if !colliding || wall_slide_timer < 0.0:
		machine.transition("fall")
		return
