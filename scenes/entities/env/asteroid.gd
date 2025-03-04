extends RigidBody2D
class_name Asteroid

# Properties
const MAX_NUM_DEBRIS: int = 2
const MIN_NUM_DEBRIS: int = 5

# Connect nodes
@export var debris: PackedScene
@export var debris_particle: PackedScene

# Initialize velocity, orientation and size
func _ready():
	randomize()
	linear_velocity = Vector2(randf_range(-1.0, 1.0),randf_range(-1.0, 1.0)) * 50
	rotation_degrees = randf_range(-360, 360)

# Spawn debris
func spawn_debris() -> void:
	# If packed scene is null, return
	if !debris:
		return
		
	# Create a random number of debris
	for i in randi_range(MIN_NUM_DEBRIS, MAX_NUM_DEBRIS):
		var newDebris = debris.instantiate()
		newDebris.global_position = self.global_position
		
		# Spawn into world
		get_parent().add_child(newDebris)

# Destroy self
func destroy() -> void:
	spawn_debris()
	if debris_particle != null and debris_particle.can_instantiate():
		var new_debris: CPUParticles2D = debris_particle.instantiate()
		new_debris.position = self.global_position
		new_debris.emitting = true
		get_tree().root.add_child(new_debris)
	queue_free()

func _on_detection_area_body_entered(body):
	if body is Player and body.has_method("destroy"):
		body.destroy()
