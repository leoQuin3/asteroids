extends Area2D
class_name Bullet

const SPEED: float = 800.0
var direction: Vector2 = Vector2()

func _physics_process(delta):
	position += direction.normalized() * SPEED * delta

func _on_area_entered(area):
	queue_free()

func _on_body_entered(body):
	if body is Asteroid:
		body.destroy()
	queue_free()

func _on_bullet_life_span_timeout():
	queue_free()
