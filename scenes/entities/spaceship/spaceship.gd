extends CharacterBody2D
class_name Player

const SPEED: float = 300.0
const ROTATION_SPEED: float = 2.0 * PI
#const MAX_SPEED: float = 500.0

@export var weapon: Weapon
@onready var body_sprite: = $BodySprite
@onready var collider: = $BodyCollision

#Movement
func _physics_process(delta):
	#Get input
	var thrust = Input.get_axis("ui_up","ui_down")
	var rotate = Input.get_axis("ui_left", "ui_right")
	
	#Rotate ship	
	rotation += rotate * ROTATION_SPEED * delta
	
	#Move ship
	if thrust:
		velocity.y += thrust * SPEED * cos(rotation) * delta
		velocity.x += thrust * SPEED * -sin(rotation) * delta
	
	#TODO: Enforce max speed
	
	move_and_slide()

#Input
func _input(event):
	if event.is_action_pressed("ui_accept"):
		weapon.fire() 
