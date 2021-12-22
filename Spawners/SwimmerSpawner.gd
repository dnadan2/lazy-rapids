extends Spatial

const swimmer = preload("res://Characters/Treading Water.tscn")

func _ready():
	GlobalConstants.swimmerSpawner = self

func add_swimmer(boat_global_transform):
	var swimmerInstance = swimmer.instance()
	
	swimmerInstance.set_global_transform(boat_global_transform)
	swimmerInstance.translation.y = -0.079
	add_child(swimmerInstance)
