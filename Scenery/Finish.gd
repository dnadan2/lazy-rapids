extends StaticBody

func _on_Area_body_entered(body):
	if body == GlobalConstants.lifeBoat:
		$Passengers.get_global_transform().origin.x = GlobalConstants.lifeBoat.get_global_transform().origin.x
		$Passengers.get_global_transform().origin.z = GlobalConstants.lifeBoat.get_global_transform().origin.z
		show_cheers()
		GlobalConstants.lifeBoat.finish()

func show_cheers():
	for i in range(GlobalConstants.lifeBoat.get_passenger_count()):
		get_node("Passengers/Cheering"+str(i+1)).visible = true
