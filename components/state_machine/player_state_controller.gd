class_name PlayerStateController extends StateController

@export var input_component : InputComponent

func get_input_bucket() -> InputBucket:
	return input_component.bucket
