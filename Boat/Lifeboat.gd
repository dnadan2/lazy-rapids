extends RigidBody

const ACCELERATION = 3.5
const RIVER_SPEED = 0
const ROTATION_TORQUE = 50
const GRAVITY = 9.8
var targetXPos = null

func _ready():
	GlobalConstants.lifeBoat = self
	
	for i in range($Passengers.get_children().size()):
		var multiplier = 1
		
		if i % 2 == 1:
			multiplier = -1
			
			
		$Passengers.get_child(i).scale.x *= multiplier

func rotate_pressed(delta):
	var pressedXPos = get_viewport().get_mouse_position()
	var screen_size = get_viewport().get_size()
	
	if pressedXPos > screen_size / 2:
		add_torque(Vector3(0, -ROTATION_TORQUE, 0) * delta)
	else:
		add_torque(Vector3(0, ROTATION_TORQUE, 0) * delta)

func stopTransitioningToXPos():
	targetXPos = null

func apply_downstream_force(delta):
	apply_central_impulse(Vector3(0,0,-RIVER_SPEED) * delta)

func apply_vertical_forces(delta):
	var gravityAmount = 0.5
	var bouyancyAmount = max(0, min(1, (0.17 - translation.y) / 0.17))
	
	apply_central_impulse(Vector3(0, (bouyancyAmount - gravityAmount) * GRAVITY * 2 * delta, 0))

func apply_boat_force(delta):
	var vector = Vector3(sin(rotation.y), 0, cos(rotation.y))
	apply_central_impulse(vector * ACCELERATION * delta)

func _physics_process(delta):
	if Input.is_mouse_button_pressed(1):
		rotate_pressed(delta)
	
	apply_downstream_force(delta)
	apply_boat_force(delta)
	apply_vertical_forces(delta)

func add_passenger():
	for passenger in $Passengers.get_children():
		if passenger.visible == false:
			passenger.visible = true
			return
