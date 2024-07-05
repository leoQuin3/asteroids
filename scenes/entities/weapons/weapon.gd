extends Node2D
class_name Weapon

enum STATES { READY, FIRING, RELOADING }

@export var BULLET_SCENE: PackedScene
@onready var reload_timer: = $ReloadTimer

var state: STATES = STATES.READY

#TODO: delete bullet after some time.

func change_state(new_state: STATES) -> void:
	state = new_state

func fire() -> void:
	if state == STATES.FIRING || state == STATES.RELOADING:
		return
	
	change_state(STATES.FIRING)
	
	#Create bullet and initialize position and rotation
	var bullet = BULLET_SCENE.instantiate()
	bullet.direction = Vector2.from_angle(self.global_rotation)
	bullet.global_position = self.global_position
	
	#add bullet to root scene
	get_tree().root.add_child(bullet)
	
	#Set state and reload timer
	change_state(STATES.RELOADING)
	reload_timer.start()

func _on_reload_timer_timeout():
	change_state(STATES.READY)
