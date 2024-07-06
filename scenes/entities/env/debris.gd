extends Asteroid

func _ready() -> void:
	linear_velocity = Vector2(randf_range(-1.0, 1.0),randf_range(-1.0, 1.0)) * 50
	rotation_degrees = randf_range(-360, 360)
	print(self)

func resize(size: float) -> void:
	$BodyCollision.scale *= size
	$BodySprite.scale *= size
