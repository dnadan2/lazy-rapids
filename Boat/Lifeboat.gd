extends RigidBody

const ACCELERATION = 6
const RIVER_SPEED = 0
const ROTATION_TORQUE = 50
const GRAVITY = 9.8
const WATER_LEVEL = 0.085
var targetXPos = null
var previousPositions = []
var started = false

func _ready():
	GlobalConstants.lifeBoat = self
	
	for i in range($Passengers.get_child_count()):
		var multiplier = 1
		
		if i % 2 == 1:
			multiplier = -1
			
		$Passengers.get_child(i).scale.x *= multiplier

func get_passenger_count():
	var count = 0
	
	for passenger in $Passengers.get_children():
		if passenger.visible == true:
			count += 1
	
	return count

func finish():
	for passenger in $Passengers.get_children():
		passenger.queue_free()
		passenger.hide()

func rotate_pressed(delta):
	var pressedXPos = get_viewport().get_mouse_position()
	var screen_size = get_viewport().get_size()
	
	if pressedXPos > screen_size / 2:
		add_torque(Vector3(0, -ROTATION_TORQUE, 0) * delta)
	else:
		add_torque(Vector3(0, ROTATION_TORQUE, 0) * delta)

func stopTransitioningToXPos():
	targetXPos = null

func apply_vertical_forces(delta):
	var gravityAmount = 0.5
	var bouyancyAmount = max(0, min(1, ((WATER_LEVEL * 2) - translation.y) / (WATER_LEVEL * 2)))
	
	apply_central_impulse(Vector3(0, (bouyancyAmount - gravityAmount) * GRAVITY * 2 * delta, 0))

func apply_boat_force(delta):
	var vector = Vector3(sin(rotation.y), 0, cos(rotation.y))
	apply_central_impulse(vector * ACCELERATION * delta)

func _physics_process(delta):
	previousPositions.append($Lifeboat.get_global_transform())
	
	if previousPositions.size() > 20:
		previousPositions.pop_front()
	
	if Input.is_mouse_button_pressed(1):
		rotate_pressed(delta)
	
	if started:
		apply_boat_force(delta)
		apply_vertical_forces(delta)

func add_passenger():
	for passenger in $Passengers.get_children():
		if passenger.visible == false:
			passenger.visible = true
			return

func place_passengers_in_water(amount):
	var passengerScale = $Passengers.scale 
	$Passengers.set_global_transform(previousPositions[0])
	$Passengers.scale = passengerScale
	
	for i in range($Passengers.get_child_count()-1, -1, -1):
		var passenger = $Passengers.get_child(i)
		
		if passenger.visible == true:
			GlobalConstants.swimmerSpawner.add_swimmer(passenger.get_global_transform())
			
			amount -= 1
		
		if amount == 0:
			return

func hide_passengers(amount):
	for i in range($Passengers.get_child_count()-1, -1, -1):
		var passenger = $Passengers.get_child(i)
		if passenger.visible == true:
			passenger.visible = false
			amount -= 1
		
		if amount == 0:
			return

func drop_passengers():
	var passengersDropped = min(2, get_passenger_count())
	
	place_passengers_in_water(passengersDropped)
	hide_passengers(passengersDropped)
