extends Asteroid

func _on_debris_detection_area_body_entered(body):
	if body is Player and body.has_method("destroy"):
		body.destroy()
