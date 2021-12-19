extends Spatial

func _ready():
	$AnimationPlayer2.seek(rand_range(0, $AnimationPlayer2.current_animation_length ))

func _on_Area_body_entered(body):
	if body == GlobalConstants.lifeBoat:
		queue_free()
		hide()
		
		GlobalConstants.lifeBoat.add_passenger()
