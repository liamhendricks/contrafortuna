extends Resource
class_name CharacterData

@export var total_jumps : int = 2
@export var total_bursts : int = 1
@export var burst_time : float = 0.5
@export var cname : String

var active_jump : int = 0
var active_burst : int = 0
var active_slide : bool = false
var burst_timer : Timer

func init(character : Character) -> void:
	burst_timer = Timer.new()
	burst_timer.wait_time = burst_time
	burst_timer.autostart = false
	burst_timer.one_shot = true
	character.add_child(burst_timer)

func can_jump() -> bool:
	return active_jump < total_jumps

func can_burst() -> bool:
	return burst_timer.is_stopped() && active_burst < total_bursts

func start_burst_timer() -> void:
	burst_timer.start()

func can_slide() -> bool:
	return active_slide
