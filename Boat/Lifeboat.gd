extends RigidBody

const ACCELERATION = Vector3(0,0,1)
const MAX_SPEED = 5
var targetXPos = null

func transitionToXPos(xPos, size):
	if xPos > size / 2:
		rotation_degrees.y -= 1
	else:
		rotation_degrees.y += 1
	
	if rotation_degrees.y < 0:
		rotation_degrees.y = min(-130, rotation_degrees.y)
	else:
		rotation_degrees.y = max(130, rotation_degrees.y)

func stopTransitioningToXPos():
	targetXPos = null

func _physics_process(delta):
	var velocity = Vector3(sin(rotation_degrees.y),0, cos(rotation_degrees.y)) * 10
	
	add_force(ACCELERATION * delta, Vector3.ZERO)
	
	if Input.is_mouse_button_pressed(1):
		transitionToXPos(get_viewport().get_mouse_position(), get_viewport().get_size())
