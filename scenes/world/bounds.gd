extends Node2D

# Properties
var window_width: int
var window_height: int

#Initialize properties
func _ready() -> void:
	#Get window dimensions
	window_width = get_viewport().size.x
	window_height = get_viewport().size.y

#Displace body if out of bounds
func _on_body_exited(body) -> void:
	displace_entity(body, body.global_position)

# Remove bullets moving beyond bounds
func _on_area_exited(area) -> void:
	if area is Bullet:
		area.queue_free()
	
#Displace area if out of bounds
func displace_entity(body, currentPosition: Vector2) -> void:
	if currentPosition.x < 0:
		body.global_position.x = window_width
	elif currentPosition.x > window_width:
		body.global_position.x = 0
	if currentPosition.y < 0:
		body.global_position.y = window_height
	elif currentPosition.y > window_height:
		body.global_position.y = 0
