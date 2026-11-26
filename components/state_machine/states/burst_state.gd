extends MoveState
class_name BurstState

@export var min_burst_time : float = 0.25
@export var burst_time : float = 0.75
@export var burst_power : float = 5.0

var min_burst_timer : float = 0.0
var burst_timer : float = 0.0

func enter(data : Dictionary = {}) -> void:
	super(data)
	character.movement_component.burst(-character.model_provider_component.basis.z, burst_power)
	min_burst_timer = min_burst_time
	burst_timer = burst_time

func process(delta : float) -> void:
	min_burst_timer -= delta
	burst_timer -= delta

func physics_process(_delta : float) -> void:
	var ib : InputBucket = state_controller.get_input_bucket()
	if ib.actions.has(InputBucket.MOVES.JUMPING) && can_jump():
		machine.transition("jump")
		return

	if character.raycast_component.any_colliding() && character.velocity.y < 0.0 && character.character_data.can_slide():
		machine.transition("wall_slide")
		return

	if !character.is_on_floor():
		if burst_timer < 0.0:
			machine.transition("fall")
			return
	else:
		if ib.actions.has(InputBucket.MOVES.MOVING):
			machine.transition("run")
			return
		else:
			machine.transition("idle")
			return

func can_jump() -> bool:
	if min_burst_timer < 0.0:
		return true
	return false
