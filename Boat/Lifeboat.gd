extends RigidBody

const ACCELERATION = 10
var targetXPos = null

func transitionToXPos(xPos, size, delta):
	if xPos > size / 2:
		add_torque(Vector3(0,-50,0) * delta)
	else:
		add_torque(Vector3(0,50,0) * delta)

func stopTransitioningToXPos():
	targetXPos = null

func _physics_process(delta):
	apply_central_impulse(Vector3(0,0,-5) * delta)
	
	var velocity = Vector3(sin(rotation_degrees.y),0, cos(rotation_degrees.y)) * 10
	
	if Input.is_mouse_button_pressed(2):
		var vector = Vector3(sin(rotation.y), 0, cos(rotation.y))
		apply_central_impulse(vector * ACCELERATION * delta)
	
	if Input.is_mouse_button_pressed(1):
		transitionToXPos(get_viewport().get_mouse_position(), get_viewport().get_size(), delta)
	
	var gravity = 0.5
	var bouyancy = max(0, min(1, (0.17 - translation.y) / 0.17))
	
	apply_central_impulse(Vector3(0, (bouyancy - gravity) * 9.8 * 2 * delta, 0))
