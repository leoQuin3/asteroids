extends RigidBody2D
class_name Asteroid

#Initialize initial velocity
func _ready():
	var initialVelocity = Vector2(randf_range(-1.0, 1.0),randf_range(-1.0, 1.0)) * 50
	linear_velocity = initialVelocity

#Destroy self
func destroy() -> void:
	queue_free()
