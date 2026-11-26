extends JumpState
class_name WallKickState

@export var kick_power : float = 7.5

var kick_normal : Vector3

func enter(data : Dictionary = {}) -> void:
	kick_normal = character.raycast_component.get_collision_normal()
	character.movement_component.burst(kick_normal, kick_power)
	super(data)

func physics_process(delta : float) -> void:
	super(delta)
	character.movement_component.face_dir(character.model_provider_component, -kick_normal, delta)
