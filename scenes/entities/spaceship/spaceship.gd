extends CharacterBody2D
class_name Player

# Properties
const THRUST_SPEED: float = 250.0
const TURN_SPEED: float = 5.0
const MAX_SPEED: float = 250.0

# Connect nodes
@export var weapon: Weapon
@export var debris_particle: PackedScene
@export var thrust_sprite: AnimatedSprite2D

# Movement
func _physics_process(delta):
	# Get input
	var thrustInput = Input.get_axis("ui_up","ui_down")
	var rotateInput = Input.get_axis("ui_left", "ui_right")
	
	# Rotate ship
	rotation += rotateInput * TURN_SPEED * delta
	
	# Move ship
	if thrustInput:
		velocity.y += thrustInput * THRUST_SPEED * cos(rotation) * delta
		velocity.x += thrustInput * THRUST_SPEED * -sin(rotation) * delta
		thrust_sprite.play("thrust")
	
	# Enforce max speed
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED
	
	# Update
	move_and_slide()

# Input
func _input(event):
	if weapon and event.is_action_pressed("ui_accept"):
		weapon.fire()
	
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
		thrust_sprite.play("thrust")
	if Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_down"):
		thrust_sprite.play("idle")

# Delete self
func destroy() -> void:
	if debris_particle.can_instantiate():
		var debris: CPUParticles2D = debris_particle.instantiate()
		debris.position = self.global_position
		debris.emitting = true
		get_tree().root.add_child(debris)
	queue_free()
