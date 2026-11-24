class_name FallState extends MoveState

@export var coyote_time : float = 0.1
@export var jump_buffer_time : float = 0.1

var coyote_timer : float = 0.0
var jump_buffer_timer : float = 0.0

func enter(_data : Dictionary = {}) -> void:
	coyote_timer = coyote_time

func process(delta : float) -> void:
	coyote_timer -= delta

func physics_process(delta : float) -> void:
	super(delta)
	if character.is_on_floor():
		machine.transition("idle")
		return

func can_jump() -> bool:
	if coyote_time > 0.0:
		return true

	return false
