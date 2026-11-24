extends CharacterBody3D
class_name Character

@onready var model_provider_component : ModelProviderComponent = $ModelProviderComponent
@onready var movement_component : MovementComponent = $MovementComponent
@onready var state_machine : StateMachine = $StateMachine

func _ready() -> void:
	state_machine.init()
