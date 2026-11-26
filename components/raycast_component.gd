extends Node3D
class_name RaycastComponent

var rays : Array[RayCast3D]

func _ready() -> void:
	rays.clear()

	for child : Node in get_children():
		if child is RayCast3D:
			rays.append(child)

func any_colliding() -> bool:
	for ray : RayCast3D in rays:
		if ray.is_colliding():
			return true

	return false

func get_collider() -> Object:
	for ray : RayCast3D in rays:
		if ray.is_colliding():
			return ray.get_collider()

	return null

func get_collision_normal() -> Vector3:
	for ray : RayCast3D in rays:
		if ray.is_colliding():
			return ray.get_collision_normal()

	return Vector3.ZERO
