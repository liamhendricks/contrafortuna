extends CharacterBody3D
class_name Character

@onready var model_provider_component : ModelProviderComponent = $ModelProviderComponent
@onready var movement_component : MovementComponent = $MovementComponent
@onready var raycast_component : RaycastComponent = $RaycastComponent

@export var character_data : CharacterData

func _ready() -> void:
	character_data.init(self)
