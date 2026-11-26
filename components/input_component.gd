class_name InputComponent extends Node

@export var camera_component : CameraComponent

var bucket : InputBucket

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	bucket = InputBucket.new()

func _input(_event: InputEvent) -> void:
	set_input()
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()

func set_input() -> void:
	bucket.actions.clear()

	#
	#bucket.input_direction = Input.get_vector("left", "right", "forward", "backward")
	#bucket.move_direction = Vector3(bucket.input_direction.x, 0.0, bucket.input_direction.y)

	bucket.input_direction = Input.get_vector("left", "right", "forward", "backward")
	var forward : Vector3 = -camera_component.global_transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()

	var right : Vector3 = forward.cross(Vector3.UP)
	bucket.move_direction = (right * bucket.input_direction.x - forward * bucket.input_direction.y).limit_length(1.0)
	if bucket.input_direction == Vector2.ZERO:
		bucket.actions.append(InputBucket.MOVES.IDLING)
	else:
		bucket.actions.append(InputBucket.MOVES.MOVING)

	if Input.is_action_pressed("jump"):
		bucket.actions.append(InputBucket.MOVES.JUMPING)

	if Input.is_action_pressed("burst"):
		bucket.actions.append(InputBucket.MOVES.BURSTING)
