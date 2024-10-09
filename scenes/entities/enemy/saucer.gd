extends CharacterBody2D
class_name Saucer

# States
enum STATES {IDLE, ATTACK, CHASE}

# Properties
const SPEED: float = 100.0
var player: Player

# Connect nodes
@export var weapon: Weapon
@export var weapon_holder: Node2D
@export var attack_timer: Timer
@export var chase_timer: Timer

# Get player upon entering scene
func _enter_tree():
	player = get_tree().get_first_node_in_group("Player")

# Update every frame
func _process(delta):
	# TODO: Implement state machine using C#
	move_and_slide()

# Follow Player
func chase() -> void:
	var last_Position = self.global_position
	var new_Direction = (player.global_position - last_Position).normalized()
	self.velocity = new_Direction * SPEED

#Shoot at Player
func attack() -> void:
	weapon_holder.look_at(player.global_position)
	weapon.fire()

# Delete self
func destroy() -> void:
	queue_free()
