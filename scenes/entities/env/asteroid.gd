extends RigidBody2D
class_name Asteroid

@export var debris: PackedScene
@export var MAX_NUM_DEBRIS: int = 0
@export var MIN_NUM_DEBRIS: int = 2
@export var INIT_RESIZE_RANGE: float = 0.0

# Initialize velocity, orientation and size
func _ready():
	linear_velocity = Vector2(randf_range(-1.0, 1.0),randf_range(-1.0, 1.0)) * 50
	rotation_degrees = randf_range(-360, 360)
	
	# Randomly scale
	var randomScale = randf_range(1 - INIT_RESIZE_RANGE, 1 + INIT_RESIZE_RANGE)
	$BodyCollision.scale *= randomScale
	$BodySprite.scale *= randomScale

# TODO: break asteroid upon destruction
# Destroy self
func destroy() -> void:
	spawn_debris()
	queue_free()

# Spawn debris
func spawn_debris() -> void:
	# If packed scene is null, return
	if !debris:
		return
	
	#Instantiate a random number of times
	for i in randi_range(MIN_NUM_DEBRIS, MAX_NUM_DEBRIS):
		var newDebris = debris.instantiate()
		newDebris.global_position = self.global_position
		get_parent().add_child(newDebris)
