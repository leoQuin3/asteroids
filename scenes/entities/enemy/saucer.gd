extends CharacterBody2D
class_name Saucer

enum STATES {IDLE, ATTACK, CHASE}
@export var initialState: STATES = STATES.IDLE
@export var SPEED: float = 100.0
@export var weapon: Weapon
@onready var player: Player = get_tree().get_first_node_in_group("Player")
@onready var weapon_holder = $WeaponHolder
@onready var attack_timer = $AttackTimer
@onready var chase_timer = $ChaseTimer

func _process(delta):
	# TODO: Implement state machine
	move_and_slide()

# Follow Player
func chase():
	var last_Position = self.global_position
	var new_Direction = (player.global_position - last_Position).normalized()
	self.velocity = new_Direction * SPEED

#Shoot at Player
func attack():
	weapon_holder.look_at(player.global_position)
	weapon.fire()
