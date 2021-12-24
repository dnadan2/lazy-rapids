extends Node2D

signal countdown_finished

func _ready():
	self.connect("countdown_finished", GlobalConstants.lifeBoat, "start")
	self.connect("countdown_finished", GlobalConstants.controls, "hide")
	
	call_function_after('set_2_text', 1)
	call_function_after('set_1_text', 2)
	call_function_after('set_go_text', 3)
	call_function_after('hide', 4)
	window_resize()
	get_tree().get_root().connect("size_changed", self, "window_resize")

func set_2_text():
	$Label.text = '2'

func set_1_text():
	$Label.text = '1'

func set_go_text():
	$Label.text = 'Go!'
	
	emit_signal("countdown_finished")

func call_function_after(function, seconds):
	var timer = Timer.new()
	timer.set_wait_time(seconds)
	timer.connect("timeout", self, function) 
	timer.set_one_shot(true)
	add_child(timer)
	timer.start()

func window_resize():
	var viewport_rect = get_viewport_rect()
	position = viewport_rect.size / 2
