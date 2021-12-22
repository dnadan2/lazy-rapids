extends Spatial
var active = false

func _ready():
	$AnimationPlayer2.seek(rand_range(0, $AnimationPlayer2.current_animation_length ))
	
	call_function_after("set_active", 1)

func set_active():
	active = true

func _on_Area_body_entered(body):
	if active && body == GlobalConstants.lifeBoat:
		queue_free()
		hide()
		
		GlobalConstants.lifeBoat.add_passenger()

func call_function_after(function, seconds):
	var timer = Timer.new()
	timer.set_wait_time(seconds)
	timer.connect("timeout", self, function) 
	timer.set_one_shot(true)
	add_child(timer)
	timer.start()
