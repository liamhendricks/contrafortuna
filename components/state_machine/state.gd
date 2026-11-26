class_name State extends Resource

@export var state_name : String = ""

var character : Character
var machine : StateMachine
var state_controller : StateController

func input(_event: InputEvent) -> void:
	pass

func process(_delta : float) -> void:
	pass

func physics_process(_delta : float) -> void:
	pass

func enter(_data : Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass

func get_log_info() -> String:
	return "state = %s" % state_name
