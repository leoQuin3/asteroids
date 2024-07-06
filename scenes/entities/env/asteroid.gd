extends RigidBody2D
class_name Asteroid

@export var debris: PackedScene
@export var MAX_NUM_DEBRIS: int = 0
@export var MIN_NUM_DEBRIS: int = 0

# Initialize velocity, orientation and children nodes
func _ready():
	linear_velocity = Vector2(randf_range(-1.0, 1.0),randf_range(-1.0, 1.0)) * 50
	rotation_degrees = randf_range(-360, 360)

# TODO: break asteroid upon destruction
# Destroy self
func destroy() -> void:
	spawn_debris()
	queue_free()

func spawn_debris() -> void:
	if !debris:
		return
	for i in randi_range(MIN_NUM_DEBRIS, MAX_NUM_DEBRIS):
		var newDebris = debris.instantiate()
		newDebris.global_position = self.global_position
		newDebris.resize(randf_range(0.5, 1.5))
		get_parent().add_child(newDebris)
