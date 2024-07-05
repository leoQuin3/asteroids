extends Node2D

var WINDOW_WIDTH: int
var WINDOW_HEIGHT: int

#Initialize properties
func _ready() -> void:
	#Get window dimensions
	WINDOW_WIDTH = get_viewport().size.x
	WINDOW_HEIGHT = get_viewport().size.y

#Displace body if out of bounds
func _on_body_exited(body) -> void:
	displace_entity(body, body.global_position)
		
#Displace area if out of bounds
func _on_area_exited(area) -> void:
	if area is Bullet:
		area.queue_free()
	
#Move body to other side
func displace_entity(body, currentPosition: Vector2) -> void:
	#TODO: Calculate body's trajectory to displace linearly instead of if-statements
	
	#TODO: Replace following if-statements
	if currentPosition.x < 0:
		body.global_position.x = WINDOW_WIDTH
	elif currentPosition.x > WINDOW_WIDTH:
		body.global_position.x = 0
	if currentPosition.y < 0:
		body.global_position.y = WINDOW_HEIGHT
	elif currentPosition.y > WINDOW_HEIGHT:
		body.global_position.y = 0
