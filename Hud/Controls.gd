extends Node2D

const margin = 5
const halfArrowSize = 250

func _ready():
	window_resize()
	get_tree().get_root().connect("size_changed", self, "window_resize")
	
func window_resize():
	var viewport_rect = get_viewport_rect()
	
	$RotateLeft.rect_position.x = viewport_rect.size.x / 4 - halfArrowSize
	$RotateLeft.rect_position.y = viewport_rect.size.y / 2 - halfArrowSize
	
	$RotateRight.rect_position.x = 3 * viewport_rect.size.x / 4 - halfArrowSize
	$RotateRight.rect_position.y = viewport_rect.size.y / 2 - halfArrowSize
	
	var colourBoxXSize = viewport_rect.size.x / 2 - margin * 2
	var colourBoxYSize = viewport_rect.size.y - margin * 2
	
	$LeftColour.rect_position = Vector2(margin, viewport_rect.size.y / 2 - colourBoxYSize / 2)
	$LeftColour.rect_size = Vector2(colourBoxXSize, colourBoxYSize)
	
	$RightColour.rect_position = Vector2(viewport_rect.size.x / 2 + margin, viewport_rect.size.y / 2 - colourBoxYSize / 2)
	$RightColour.rect_size = Vector2(colourBoxXSize, colourBoxYSize)

func _process(delta):
	$RotateLeft.set_rotation($RotateLeft.get_rotation() - 1 * delta)
	$RotateRight.set_rotation($RotateRight.get_rotation() + 1 * delta)
