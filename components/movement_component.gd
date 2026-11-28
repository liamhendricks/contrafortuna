class_name MovementComponent extends Node

@export var state_controller : StateController
@export var body_to_move : Character
@export var rotation_speed : float = 10.0
@export var max_speed : float = 20.0
@export var max_floor_angle : float = 0.78

var acceleration : float = 50.0
var gravity : float = 9.8
var drag : float = 75.0

var velocity : Vector3 = Vector3.ZERO
var frozen : bool = false

func _ready() -> void:
	await body_to_move.ready
	body_to_move.floor_max_angle = max_floor_angle

func jump(height : float = 2.0) -> void:
	velocity.y = sqrt(2.0 * gravity * height)

func burst(dir : Vector3, power : float) -> void:
	var burst_power : float = sqrt(2.0 * power * power)
	velocity = dir * burst_power

func _physics_process(delta : float) -> void:
	if frozen:
		return

	var input_bucket : InputBucket = state_controller.get_input_bucket()
	var dir : Vector3 = state_controller.get_input_bucket().move_direction
	dir.y = 0.0
	dir = dir.limit_length(1.0)

	var vertical_velocity : float = velocity.y
	var horizontal_velocity : Vector3 = Vector3(velocity.x, 0.0, velocity.z)

	# apply drag if no input
	if input_bucket.input_direction.is_zero_approx() || input_bucket.input_direction == Vector2.ZERO:
		horizontal_velocity = horizontal_velocity.move_toward(Vector3.ZERO, drag * delta)
	else:
		horizontal_velocity = horizontal_velocity.move_toward(dir * max_speed, acceleration * delta)
		face_dir(body_to_move.model_provider_component, -dir, delta)

	# re-apply vertical velocity
	velocity = horizontal_velocity
	velocity.y = vertical_velocity - gravity * delta

	# apply movement to the character
	body_to_move.velocity = velocity
	body_to_move.move_and_slide()
	velocity = body_to_move.velocity

func face_dir(from : Node3D, dir : Vector3, delta : float) -> void:
	var target_angle : float = atan2(dir.x, dir.z)
	from.rotation.y = lerp_angle(from.rotation.y, target_angle, rotation_speed * delta)
