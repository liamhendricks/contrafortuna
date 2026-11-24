class_name MovementComponent extends Node

@export var state_controller : StateController
@export var body_to_move : Character
@export var max_speed : float = 10.0
@export var acceleration : float = 50.0
@export var gravity : float = 9.8
@export var drag : float = 50.0
@export var max_floor_angle : float = 0.78

var velocity : Vector3 = Vector3.ZERO
var frozen : bool = false

func jump(height : float = 2.0) -> void:
	body_to_move.velocity.y = sqrt(2.0 * gravity * height)

func _physics_process(delta : float) -> void:
	if frozen:
		return

	var dir : Vector3 = state_controller.get_input_bucket().move_direction
	dir.y = 0.0
	dir = dir.limit_length(1.0)

	var vertical_velocity : float = velocity.y
	var horizontal_velocity : Vector3 = Vector3(velocity.x, 0.0, velocity.z)

	# apply drag if no input
	if state_controller.get_input_bucket().input_direction.is_zero_approx():
		horizontal_velocity = horizontal_velocity.move_toward(Vector3.ZERO, drag * delta)
	else:
		horizontal_velocity = horizontal_velocity.move_toward(dir * max_speed, acceleration * delta)

	# re-apply vertical velocity
	velocity = horizontal_velocity
	velocity.y = vertical_velocity - gravity * delta

	# apply movement to the character
	body_to_move.velocity = velocity
	body_to_move.move_and_slide()
	velocity = body_to_move.velocity
