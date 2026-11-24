class_name InputBucket extends RefCounted

enum MOVES {IDLING, MOVING, JUMPING, BURSTING}

var actions : Array[MOVES]
var input_direction : Vector2
var move_direction : Vector3
