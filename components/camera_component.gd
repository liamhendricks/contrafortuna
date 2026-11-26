extends Node3D
class_name CameraComponent

@export_range(0.0, 1.0) var mouse_sensitivity : float = 0.25
@export var tilt_upper_limit : float = PI / 3.0
@export var tilt_lower_limit : float = -PI / 6.0
@export var camera : Camera3D

var _camera_input_direction : Vector2 = Vector2.ZERO

func _unhandled_input(event : InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var m_event : InputEventMouseMotion = event
		_camera_input_direction = m_event.screen_relative * mouse_sensitivity

func _physics_process(delta: float) -> void:
	rotation.x -= _camera_input_direction.y * delta
	rotation.x = clamp(rotation.x, tilt_lower_limit, tilt_upper_limit)
	rotation.y += -_camera_input_direction.x * delta

	_camera_input_direction = Vector2.ZERO
