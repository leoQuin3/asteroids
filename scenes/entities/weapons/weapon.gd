extends Node2D
class_name Weapon

enum STATES { READY, FIRING, RELOADING }

const reload_time: float = 0.1

@export var BULLET_SCENE: PackedScene
@export var reload_timer: Timer
@export var shooter: CollisionObject2D

var state: STATES = STATES.READY

func _ready():
	reload_timer.wait_time = reload_time
	state = STATES.READY

func change_state(new_state: STATES) -> void:
	state = new_state

func fire() -> void:
	# Return if weapon is not ready (i.e. currently firing or reloading)
	if state != STATES.READY:
		return
	
	change_state(STATES.FIRING)
	
	# Create bullet
	var bullet: Bullet = BULLET_SCENE.instantiate()
	bullet.direction = Vector2.from_angle(self.global_rotation).normalized()
	bullet.global_position = self.global_position
	bullet.shooter = self.shooter
	
	# Add bullet to root scene
	get_tree().root.add_child(bullet)
	
	# Set state and reload timer
	change_state(STATES.RELOADING)
	reload_timer.start()

func _on_reload_timer_timeout():
	change_state(STATES.READY)
