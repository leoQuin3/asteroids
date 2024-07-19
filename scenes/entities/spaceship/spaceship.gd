extends CharacterBody2D
class_name Player

@export var THRUST_SPEED: float = 300.0
@export var MAX_SPEED: float = 500.0
@export var weapon: Weapon
@export var body_sprite: Sprite2D
@export var collider: CollisionPolygon2D

const ROTATION_SPEED: float = 2.0 * PI

#Movement
func _physics_process(delta):
	# Get input
	var thrustVector = Input.get_axis("ui_up","ui_down")
	var rotateVector = Input.get_axis("ui_left", "ui_right")
	
	# Rotate ship	
	rotation += rotateVector * ROTATION_SPEED * delta
	
	# Move ship
	if thrustVector:
		velocity.y += thrustVector * THRUST_SPEED * cos(rotation) * delta
		velocity.x += thrustVector * THRUST_SPEED * -sin(rotation) * delta
	
	# Enforce max speed
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED
	print(velocity.length())
	
	# Update
	move_and_slide()

# Input
func _input(event):
	if weapon and event.is_action_pressed("ui_accept"):
		weapon.fire()
