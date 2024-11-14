extends Node2D
class_name Weapon

enum STATES { READY, FIRING }

# Set reload time
@export var reload_time: float = 0.1

# Connect nodes
@export var BULLET_SCENE: PackedScene
@export var reload_timer: Timer
@export var shooter: CollisionObject2D

var state: STATES = STATES.READY

# Initialize
func _ready():
	reload_timer.wait_time = reload_time
	state = STATES.READY

# Switch to state
func change_state(new_state: STATES) -> void:
	state = new_state

# Shoot bullet
func fire() -> void:
	# Return if weapon is not ready (i.e. currently firing or reloading)
	if state != STATES.READY:
		return
	
	# Add bullet to root scene
	get_tree().root.add_child(new_bullet())
	
	# Set state and reload timer
	change_state(STATES.FIRING)
	reload_timer.start()

# Create bullet
func new_bullet():
	var bullet: Bullet = BULLET_SCENE.instantiate()
	bullet.direction = Vector2.from_angle(self.global_rotation).normalized()
	bullet.global_position = self.global_position
	bullet.shooter = self.shooter
	return bullet

func _on_reload_timer_timeout():
	change_state(STATES.READY)
