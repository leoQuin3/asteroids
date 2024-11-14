extends Area2D
class_name Bullet

# Properties
const SPEED: float = 500.0
var direction: Vector2 = Vector2()
var shooter: CollisionObject2D

# Connect signal to function
func _ready():
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	
# Process every frame
func _physics_process(delta):
	position += direction.normalized() * SPEED * delta

# Call when entering areas
func _on_area_entered(area):
	queue_free()

# Call when entering bodies
func _on_body_entered(body):
	if body == shooter:
		return
	if body.has_method("destroy"):
		body.destroy()
	queue_free()

func _on_bullet_lifespan_timeout() -> void:
	queue_free()
