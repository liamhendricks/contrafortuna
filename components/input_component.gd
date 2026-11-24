class_name InputComponent extends Node

var bucket : InputBucket

func _ready() -> void:
	bucket = InputBucket.new()

func _input(_event: InputEvent) -> void:
	set_input()
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()

func set_input() -> void:
	bucket.input_direction = Input.get_vector("left", "right", "forward", "backward")
	bucket.move_direction = Vector3(bucket.input_direction.x, 0.0, bucket.input_direction.y)
	if bucket.input_direction == Vector2.ZERO:
		bucket.actions.append(InputBucket.MOVES.IDLING)
	else:
		bucket.actions.append(InputBucket.MOVES.MOVING)

	if Input.is_action_pressed("jump"):
		bucket.actions.append(InputBucket.MOVES.JUMPING)

	if Input.is_action_pressed("burst"):
		bucket.actions.append(InputBucket.MOVES.BURSTING)
