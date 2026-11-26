extends Node

@export var log_method : String = "get_log_info"

func _ready() -> void:
	for sig : Dictionary in SignalBus.get_signal_list():
		if sig["name"] is String:
			var signame : String = sig["name"]
			var err : Error = SignalBus.connect(signame, _signal_log.bind(sig["name"]))
			if err == 0:
				print("connected to %s" % sig["name"])

func _signal_log(...args : Array[Variant]) -> void:
	if len(args) == 0:
		return

	var msg : String = "[signalbus] emitted: %s, data: " % args[len(args)-1]
	for arg : Variant in args:
		if typeof(arg) == TYPE_OBJECT:
			var obj : Object = null
			if arg is Object:
				obj = arg
			if obj == null:
				continue
			if obj.has_method(log_method):
				msg += obj.call(log_method) + " "

	_log(msg)

func _log(msg : String) -> void:
	print(msg)
